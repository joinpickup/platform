import React from "react";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import PlacesScreen from "../src/screens/postAuth/core/places/PlacesScreen";
import EventsScreen from "../src/screens/postAuth/core/events/EventsScreen";
import ProfileScreen from "../src/screens/postAuth/core/profile/ProfileScreen";
import EventScreen from "../src/screens/postAuth/event/EventScreen";
import Home from "../src/components/icons/Home";
import Places from "../src/components/icons/Places";
import Events from "../src/components/icons/Events";
import Profile from "../src/components/icons/Profile";
import DiscoverNavigator from "../src/screens/postAuth/core/discover/navigator/DiscoverNavigator";
import DiscoverScreen from "../src/screens/postAuth/core/discover/DiscoverScreen";
import { Colors } from "../src/styles/theme";
import PostScreen from "../src/screens/postAuth/post/PostScreen";
import EventsNavigator from "../src/screens/postAuth/core/events/navigator/EventsNavigator";
import EventPage from "../src/screens/postAuth/event/EventScreen";

const Stack = createNativeStackNavigator();
const Tab = createBottomTabNavigator();

function CoreNavigator() {
  return (
    <Tab.Navigator
      screenOptions={{
        headerShown: false,
        tabBarActiveTintColor: "white",
        tabBarInactiveTintColor: Colors.gray["500"],
        tabBarStyle: {
          backgroundColor: Colors.gray["700"],
          borderTopColor: Colors.gray["800"]
        },
      }}
    >
      <Tab.Screen
        name="Home"
        component={DiscoverNavigator}
        options={{
          tabBarIcon: ({ color, size }) => (
            <Home name="home" color={color} size={size} />
          ),
        }}
      />
      <Tab.Screen
        name="Places"
        component={PlacesScreen}
        options={{
          tabBarIcon: ({ color, size }) => (
            <Places name="home" color={color} size={size} />
          ),
        }}
      />
      <Tab.Screen
        name="Events"
        component={EventsNavigator}
        options={{
          tabBarIcon: ({ color, size }) => (
            <Events name="events" color={color} size={size} />
          ),
        }}
      />
      <Tab.Screen
        name="Profile"
        component={ProfileScreen}
        options={{
          tabBarIcon: ({ color, size }) => (
            <Profile name="home" color={color} size={size} />
          ),
        }}
      />
    </Tab.Navigator>
  );
}
export function PostAuthNavigator() {
  return (
    <Stack.Navigator
      initialRouteName="Core"
    >
      <Stack.Screen name="Core" component={CoreNavigator} options={{headerShown: false}} />
      <Stack.Screen name="EventScreen" component={EventPage} />
      <Stack.Screen name="PostScreen" component={PostScreen} />
    </Stack.Navigator>
  );
}
