import React from "react";
import { ScrollView, View } from "react-native";
import DiscoverAppBar from "../../components/surfaces/appbars/DiscoverAppBar";
import HomeBody from "./HomeBody";

export default function HomeScreen() {
  return (
    <View className="p-4 flex flex-col flex-1">
      <DiscoverAppBar />
      <ScrollView className="flex-1">
        <HomeBody />
      </ScrollView>
    </View>
  );
}
