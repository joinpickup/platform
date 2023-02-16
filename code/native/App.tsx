import React, { useState } from "react";
import { SafeAreaView } from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import BottomAppBar from "./src/components/navigation/BottomAppBar";
import EventsScreen from "./src/screens/events/EventsScreen";
import PlacesScreen from "./src/screens/places/PlacesScreen";
import ProfileScreen from "./src/screens/profile/ProfileScreen";
import HomeScreen from "./src/screens/home/HomeScreen";

const screens = [
  <HomeScreen />,
  <PlacesScreen />,
  <EventsScreen />,
  <ProfileScreen />,
];
export default function App() {
  const [tab, setTab] = useState(0);

  return (
    <NavigationContainer>
      <SafeAreaView className="bg-gray-600 h-screen">
        {screens[tab]}
        <BottomAppBar setTab={setTab} tab={tab} />
      </SafeAreaView>
    </NavigationContainer>
  );
}
