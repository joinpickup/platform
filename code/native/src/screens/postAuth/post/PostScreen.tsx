import { useRoute } from "@react-navigation/native";
import React, { useEffect, useState } from "react";
import { SafeAreaView, Text, View } from "react-native";

export default function PostScreen() {
  const route = useRoute();
  const [id] = useState(route.params.id);

  return (
    <SafeAreaView>
      <Text
        style={{
          fontFamily: "Nunito-Bold"
        }}
        className="text-2xl text-gray-300"
      >Post {id}</Text>
    </SafeAreaView>
  );
}
