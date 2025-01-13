import { useEffect } from 'react';
import { Text, View, StyleSheet, Button } from 'react-native';
import { multiply, clearAuthentication } from 'truvideo-react-turbo-core-sdk';

const result = multiply(3, 7);

export default function App() {
  useEffect(() => {
    //  authenticate('EPhPPsbv7e',await generatePayload(), '9lHCnkfeLl', '')
    //   .then((resp) => {
    //     console.log('result', resp);
    //   })
    //   .catch((error) => {
    //     console.log('error', error);
    //   });
  }, []);

  const logOut = () => {
    clearAuthentication()
      .then((response) => {
        console.log('result', response);
      })
      .catch((error) => {
        console.log('error', error);
      });
  };
  return (
    <View style={styles.container}>
      <Text>Result: {result}</Text>
      <Button
        onPress={logOut}
        title="Logout..."
        color="#eb4034"
        accessibilityLabel="Clear authentication function will called here"
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
