import { StackNavigationState, useNavigation } from "@react-navigation/native";
import React from "react";
import { Pressable, TouchableOpacity, View } from "react-native";
import Card from "../../../../components/surfaces/cards/Card";

const data = [1, 2, 3, 4, 5, 6, 7, 8];
export default function BoardBody() {
  const navigator = useNavigation<StackNavigationState<any>>();

  return (
    <View className="flex py-2 flex-col space-y-2">
      {data.map((datum) => {
        return (
          <View key={datum}>
            <Pressable
              onPress={() => {
                console.log("go to");
              }}
            >
              <TouchableOpacity
              onPress={() => {navigator.push("Event")}}
              >
                <Card />
              </TouchableOpacity>
            </Pressable>
          </View>
        );
      })}
    </View>
  );
}
