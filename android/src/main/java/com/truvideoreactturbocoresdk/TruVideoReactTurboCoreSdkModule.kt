package com.truvideoreactturbocoresdk

import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.module.annotations.ReactModule
import com.truvideo.sdk.core.TruvideoSdk
import com.truvideo.sdk.core.interfaces.TruvideoSdkCallback
import com.truvideo.sdk.model.exceptions.TruvideoSdkException
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.io.BufferedReader
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL
import java.security.InvalidKeyException
import java.security.NoSuchAlgorithmException
import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec
import org.json.JSONObject

@ReactModule(name = TruVideoReactTurboCoreSdkModule.NAME)
class TruVideoReactTurboCoreSdkModule(reactContext: ReactApplicationContext) :
  NativeTruVideoReactTurboCoreSdkSpec(reactContext) {

  private val scope = CoroutineScope(Dispatchers.IO)

  override fun getName(): String = NAME

  override fun multiply(a: Double, b: Double): Double = a * b

  // -------------------------------------------------------
  // Auth status
  // isAuthenticated() is a FUNCTION returning boolean
  // -------------------------------------------------------

  override fun isAuthenticated(promise: Promise) {
    promise.resolve(TruvideoSdk.isAuthenticated)
  }

  override fun isAuthenticationExpired(promise: Promise) {
    // SDK has no isAuthenticationExpired — derive from isAuthenticated
    promise.resolve(!TruvideoSdk.isAuthenticated)
  }

  // -------------------------------------------------------
  // Payload
  // -------------------------------------------------------

  override fun generatePayload(promise: Promise) {
    promise.resolve(TruvideoSdk.generatePayload())
  }

  // -------------------------------------------------------
  // Classic auth — callback overload (non-suspend)
  // Signature: authenticate(apiKey, payload, signature, externalId, callback)
  // -------------------------------------------------------

  override fun authenticate(
    apiKey: String,
    payload: String,
    signature: String,
    externalId: String,
    promise: Promise
  ) {
    TruvideoSdk.authenticate(
      apiKey,
      payload,
      signature,
      externalId,
      object : TruvideoSdkCallback<Unit> {
        override fun onComplete(result: Unit) {
          promise.resolve("Authenticate Successful")
        }
        override fun onError(exception: TruvideoSdkException) {
          promise.reject("AUTH_ERROR", exception.toString())
        }
      }
    )
  }

  // -------------------------------------------------------
  // Init — waitAuthReady suspend → run in coroutine
  // -------------------------------------------------------

  override fun initAuthentication(promise: Promise) {
    scope.launch {
      try {
        TruvideoSdk.waitAuthReady()
        promise.resolve("Init Successful")
      } catch (e: Exception) {
        e.printStackTrace()
        promise.reject("INIT_ERROR", e.toString())
      }
    }
  }

  // -------------------------------------------------------
  // Logout — clearAuthentication suspend → run in coroutine
  // -------------------------------------------------------

  override fun clearAuthentication(promise: Promise) {
    scope.launch {
      try {
        TruvideoSdk.clearAuthentication()
        promise.resolve("Logout Successful")
      } catch (e: Exception) {
        e.printStackTrace()
        promise.reject("CLEAR_AUTH_ERROR", e.toString())
      }
    }
  }

  // -------------------------------------------------------
  // OTP — generate
  // Pure HTTP, no external dependency needed
  // -------------------------------------------------------

  @ReactMethod
  override fun generateOtp(
    baseUrl: String,
    apiKey: String,
    secret: String,
    externalId: String,
    promise: Promise
  ) {
    scope.launch {
      try {
        if (apiKey.isBlank()) throw IllegalArgumentException("apiKey cannot be empty")
        if (secret.isBlank()) throw IllegalArgumentException("secret cannot be empty")
        if (externalId.isBlank()) throw IllegalArgumentException("externalId cannot be empty")

        val cleanBaseUrl = baseUrl.trimEnd('/')
        val endpoint = "$cleanBaseUrl/api/v1/auth/otp/generate"
        val body = JSONObject().put("externalId", externalId).toString()
        val signature = toSha256String(secret, body)
          ?: throw IllegalStateException("Failed to generate request signature")

        val connection = (URL(endpoint).openConnection() as HttpURLConnection).apply {
          requestMethod = "POST"
          connectTimeout = 15_000
          readTimeout = 15_000
          doOutput = true
          setRequestProperty("Content-Type", "application/json")
          setRequestProperty("x-authentication-api-key", apiKey)
          setRequestProperty("x-authentication-signature", signature)
        }

        try {
          connection.outputStream.use {
            it.write(body.toByteArray(Charsets.UTF_8))
          }

          val status = connection.responseCode
          val stream = if (status in 200..299) connection.inputStream
          else connection.errorStream
          val responseText = stream?.use {
            BufferedReader(InputStreamReader(it)).readText()
          }.orEmpty()

          if (status !in 200..299) {
            val msg = runCatching {
              JSONObject(responseText).optString("message")
                .ifBlank { JSONObject(responseText).optString("detail") }
            }.getOrDefault("")
            throw IllegalStateException(
              if (msg.isNotBlank()) "OTP generate failed ($status): $msg"
              else "OTP generate failed with status $status"
            )
          }

          val otp = runCatching {
            JSONObject(responseText).optString("otp")
          }.getOrDefault("")

          if (otp.isBlank()) throw IllegalStateException("OTP not found in response")

          promise.resolve(otp)
        } finally {
          connection.disconnect()
        }

      } catch (e: Exception) {
        e.printStackTrace()
        promise.reject("OTP_GENERATE_ERROR", e.toString())
      }
    }
  }

  // -------------------------------------------------------
  // OTP — authenticate
  // CONFIRMED: authenticate(String, Continuation) overload
  // takes the otp as the single String parameter
  // -------------------------------------------------------

  @ReactMethod
  override fun authenticateWithOtp(otp: String, promise: Promise) {
    scope.launch {
      try {
        if (otp.isBlank()) throw IllegalArgumentException("OTP cannot be empty")
        TruvideoSdk.authenticate(otp)   // single-String suspend overload
        TruvideoSdk.waitAuthReady()
        promise.resolve("OTP Authentication Successful")
      } catch (e: Exception) {
        e.printStackTrace()
        promise.reject("OTP_AUTH_ERROR", e.toString())
      }
    }
  }

  // -------------------------------------------------------
  // HMAC-SHA256 — signs the OTP generate request body
  // -------------------------------------------------------

  private fun toSha256String(secret: String, payload: String): String? {
    return try {
      val mac = Mac.getInstance("HmacSHA256")
      mac.init(SecretKeySpec(secret.toByteArray(), "HmacSHA256"))
      mac.doFinal(payload.toByteArray()).joinToString("") { "%02x".format(it) }
    } catch (e: NoSuchAlgorithmException) {
      e.printStackTrace(); null
    } catch (e: InvalidKeyException) {
      e.printStackTrace(); null
    }
  }

  companion object {
    const val NAME = "TruVideoReactTurboCoreSdk"
  }
}
