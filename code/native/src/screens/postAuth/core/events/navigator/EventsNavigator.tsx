import { createNativeStackNavigator } from "@react-navigation/native-stack";
import React from "react"
import { SafeAreaView } from "react-native";
import { Colors } from "../../../../../styles/theme";
import DiscoverAppBar from "../EventsAppBar";
import DiscoverScreen from "../DiscoverScreen";
import EventsScreen from "../EventsScreen";
import EventsAppBar from "../EventsAppBar";

const Stack = createNativeStackNavigator();

export default function EventsNavigator() {
  return (
    <Stack.Navigator screenOptions={{
      headerStyle: {
        backgroundColor: Colors.gray["700"]
      },
      header: ({ navigation, route, options, back }) => {
      return (
          <SafeAreaView>
            <EventsAppBar />
          </SafeAreaView>
        )
    }}}>
      <Stack.Screen name="EventsScreen" component={EventsScreen} />
    </Stack.Navigator>
  );
}