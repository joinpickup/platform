import { createNativeStackNavigator } from "@react-navigation/native-stack";
import React from "react";
import { SafeAreaView } from "react-native";
import { Colors } from "../../../../../styles/theme";
import PlacesAppBar from "../PlacesAppBar";
import PlaceScreen from "../../../place/PlaceScreen";
import PlacesScreen from "../PlacesScreen";

const Stack = createNativeStackNavigator();

export default function PlacesNavigator() {
  return (
    <Stack.Navigator screenOptions={{
      headerStyle: {
        backgroundColor: Colors.gray["700"]
      },
      header: ({ navigation, route, options, back }) => {
      return (
          <SafeAreaView>
            <PlacesAppBar />
          </SafeAreaView>
        )
    }}}>
      <Stack.Screen name="PlacesScreen" component={PlacesScreen} />
    </Stack.Navigator>
  );
}