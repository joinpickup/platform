import React from "react";
import { ScrollView, View } from "react-native";
import BoardAppBar from "../../../../components/surfaces/appbars/BoardAppBar";
import ProfileBody from "./ProfileBody";

export default function ProfileScreen() {
  return (
    <View className="p-4 flex flex-col flex-1">
      <BoardAppBar />
      <ScrollView className="flex-1">
        <ProfileBody />
      </ScrollView>
    </View>
  );
}
