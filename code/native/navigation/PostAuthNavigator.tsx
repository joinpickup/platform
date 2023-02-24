import React from "react";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import ProfileScreen from "../src/screens/postAuth/core/profile/ProfileScreen";
import HomeSolid from "../src/components/icons/home/HomeSolid";
import ProfileSolid from "../src/components/icons/profile/ProfileSolid";
import DiscoverNavigator from "../src/screens/postAuth/core/discover/navigator/DiscoverNavigator";
import { Colors } from "../src/styles/theme";
import PostScreen from "../src/screens/postAuth/post/PostScreen";
import EventsNavigator from "../src/screens/postAuth/core/events/navigator/EventsNavigator";
import EventPage from "../src/screens/postAuth/event/EventScreen";
import HomeOutline from "../src/components/icons/home/HomeOutline";
import MapOutline from "../src/components/icons/map/MapOutline";
import MapSolid from "../src/components/icons/map/MapSolid";
import CalendarOutline from "../src/components/icons/calendar/CalendarOutline";
import CalendarSolid from "../src/components/icons/calendar/CalendarSolid";
import ProfileOutline from "../src/components/icons/profile/ProfileOutline";
import PersonScreen from "../src/screens/postAuth/person/PersonScreen";
import PlacesNavigator from "../src/screens/postAuth/core/places/navigator/PlacesNavigator";

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
          borderTopColor: Colors.gray["800"],
        },
      }}
    >
      <Tab.Screen
        name="Home"
        component={DiscoverNavigator}
        options={{
          tabBarIcon: ({ focused, color, size }) =>
            focused ? (
              <HomeSolid name="home" color={color} size={size} />
            ) : (
              <HomeOutline name="home" color={color} size={size} />
            ),
        }}
      />
      <Tab.Screen
        name="Places"
        component={PlacesNavigator}
        options={{
          tabBarIcon: ({ focused, color, size }) =>
            focused ? (
              <MapSolid name="home" color={color} size={size} />
            ) : (
              <MapOutline name="home" color={color} size={size} />
            ),
        }}
      />
      <Tab.Screen
        name="Events"
        component={EventsNavigator}
        options={{
          tabBarIcon: ({ focused, color, size }) =>
            focused ? (
              <CalendarSolid name="events" color={color} size={size} />
            ) : (
              <CalendarOutline name="events" color={color} size={size} />
            ),
        }}
      />
      <Tab.Screen
        name="Profile"
        component={ProfileScreen}
        options={{
          tabBarIcon: ({ focused, color, size }) =>
            focused ? (
              <ProfileSolid name="profile" color={color} size={size} />
            ) : (
              <ProfileOutline name="profile" color={color} size={size} />
            ),
        }}
      />
    </Tab.Navigator>
  );
}
export function PostAuthNavigator() {
  return (
    <Stack.Navigator initialRouteName="Core">
      <Stack.Screen
        name="Core"
        component={CoreNavigator}
        options={{ headerShown: false }}
      />
      <Stack.Screen name="EventScreen" component={EventPage} />
      <Stack.Screen name="PostScreen" component={PostScreen} />
      <Stack.Screen name="PersonScreen" component={PersonScreen} />
    </Stack.Navigator>
  );
}
