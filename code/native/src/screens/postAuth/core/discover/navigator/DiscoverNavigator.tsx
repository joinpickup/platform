import { createNativeStackNavigator } from "@react-navigation/native-stack";
import React from "react";
import { SafeAreaView } from "react-native";
import { Colors } from "../../../../../styles/theme";
import DiscoverAppBar from "../DiscoverAppBar";
import DiscoverScreen from "../DiscoverScreen";

const Stack = createNativeStackNavigator();

export default function DiscoverNavigator() {
  return (
    <Stack.Navigator
      screenOptions={{
        headerStyle: {
          backgroundColor: Colors.gray["400"],
        },
        header: ({ navigation, route, options, back }) => {
          return (
            <SafeAreaView>
              <DiscoverAppBar />
            </SafeAreaView>
          );
        },
      }}
    >
      <Stack.Screen name="Discover" component={DiscoverScreen} />
    </Stack.Navigator>
  );
}
