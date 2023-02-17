import React from "react";
import { SafeAreaView, Text, View } from "react-native";
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { LoginPage } from "../src/screens/preAuth/login/LoginScreen";
import { RegisterPage } from "../src/screens/preAuth/register/RegisterPage";
import BoardScreen from "../src/screens/postAuth/core/board/BoardScreen";
import PlacesScreen from "../src/screens/postAuth/places/PlacesScreen";
import EventsScreen from "../src/screens/postAuth/core/events/EventsScreen";
import ProfileScreen from "../src/screens/postAuth/profile/ProfileScreen";
import EventScreen from "../src/screens/postAuth/event/EventScreen";

const Stack = createNativeStackNavigator();
const Tab = createBottomTabNavigator();

function CoreNavigator() {
  return (
    <Tab.Navigator>
      <Tab.Screen name="Home" component={BoardScreen} />
      <Tab.Screen name="Places" component={PlacesScreen} />
      <Tab.Screen name="Events" component={EventsScreen} />
      <Tab.Screen name="Profile" component={ProfileScreen} />
    </Tab.Navigator>
  );
}
export function PostAuthNavigator() {
    return (
        <Stack.Navigator initialRouteName="Core">
            <Stack.Screen name="Core" component={CoreNavigator} />
            <Stack.Screen name="Event" component={EventScreen} />
        </Stack.Navigator>
    )
} 