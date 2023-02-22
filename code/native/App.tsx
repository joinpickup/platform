// In App.js in a new project
import React, { useState, useCallback, useEffect } from "react";
import { DefaultTheme, NavigationContainer, Theme } from "@react-navigation/native";
import { PreAuthNavigator } from "./navigation/PreAuthNavigator";
import { PostAuthNavigator } from "./navigation/PostAuthNavigator";
import { useFonts } from 'expo-font';
import * as SplashScreen from 'expo-splash-screen';
import { DarkMode } from "./src/styles/theme";
import { View, Text } from "react-native";
import { StatusBar } from "expo-status-bar";

SplashScreen.preventAutoHideAsync();

function App() {
  const [user, setUser] = useState(true);

  const [fontsLoaded] = useFonts({
    'Nunito-Bold': require('./src/assets/fonts/Nunito-Bold.ttf'),
    'Nunito-Regular': require('./src/assets/fonts/Nunito-Regular.ttf'),
    'Nunito-SemiBold': require('./src/assets/fonts/Nunito-SemiBold.ttf'),
    'Nunito-BoldItalic': require('./src/assets/fonts/Nunito-BoldItalic.ttf'),
    'Nunito-SemiBoldItalic': require('./src/assets/fonts/Nunito-SemiBoldItalic.ttf'),
  });

  const onLayoutRootView = useCallback(async () => {
    if (fontsLoaded) {
      await SplashScreen.hideAsync()
    }
  }, [fontsLoaded]);

  if (!fontsLoaded) return null;

  return (
    <NavigationContainer theme={DarkMode}>
      <StatusBar style="light"></StatusBar>
      {user ? <PostAuthNavigator /> : <PreAuthNavigator />}
    </NavigationContainer>
  );
}

export default App;
