import React from "react";
import { Pressable, TouchableOpacity, View } from "react-native";
import Card from "../../../../components/surfaces/cards/Card";

const data = [1, 2, 3, 4, 5, 6, 7, 8];
export default function EventsBody() {
  return (
    <View className="flex flex-col space-y-2">
      {data.map((datum) => {
        return (
          <View key={datum}>
            <Pressable
              onPress={() => {
                console.log("go to");
              }}
            >
              <TouchableOpacity>
                <Card />
              </TouchableOpacity>
            </Pressable>
          </View>
        );
      })}
    </View>
  );
}
