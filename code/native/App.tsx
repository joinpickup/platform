// In App.js in a new project

import React, {useState} from 'react';
import { View, Text } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { PreAuthNavigator } from './navigation/PreAuthNavigator';
import { PostAuthNavigator } from './navigation/PostAuthNavigator';

function App() {
  const [user, setUser] = useState(true)

  return (
    <NavigationContainer>
      {
        user ?  <PostAuthNavigator /> : <PreAuthNavigator />
      }
    </NavigationContainer>
  );
}

export default App;