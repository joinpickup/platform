import React from "react";
import { ScrollView, View } from "react-native";
import BoardAppBar from "../../../../components/surfaces/appbars/BoardAppBar";
import BoardBody from "./BoardBody";

export default function BoardScreen() {
  return (
    <View className="flex flex-col flex-1">
      <View className="px-2">
        <BoardAppBar />
      </View>
      <ScrollView className="flex-1 bg-gray-700 px-2">
        <BoardBody />
      </ScrollView>
    </View>
  );
}
