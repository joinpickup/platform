import React from "react";
import { ScrollView, View } from "react-native";
import DiscoverAppBar from "../../components/surfaces/appbars/DiscoverAppBar";
import EventsBody from "./EventsBody";

export default function EventsScreen() {
  return (
    <View className="p-4 flex flex-col flex-1">
      <DiscoverAppBar />
      <ScrollView className="flex-1">
        <EventsBody />
      </ScrollView>
    </View>
  );
}
