import React from "react";
import { ScrollView, View } from "react-native";
import HomeAppBar from "../../../../components/surfaces/appbars/BoardAppBar";
import EventsBody from "./EventsBody";

export default function EventsScreen() {
  return (
    <View className="p-4 flex flex-col flex-1">
      <HomeAppBar />
      <ScrollView className="flex-1">
        <EventsBody />
      </ScrollView>
    </View>
  );
}
