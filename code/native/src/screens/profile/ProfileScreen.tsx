import React from "react";
import { ScrollView, View } from "react-native";
import DiscoverAppBar from "../../components/surfaces/appbars/DiscoverAppBar";
import ProfileBody from "./ProfileBody";

export default function ProfileScreen() {
  return (
    <View className="p-4 flex flex-col flex-1">
      <DiscoverAppBar />
      <ScrollView className="flex-1">
        <ProfileBody />
      </ScrollView>
    </View>
  );
}
