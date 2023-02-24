import { useNavigation } from "@react-navigation/native";
import React, { useState } from "react";
import { Text, View } from "react-native";

export default function DiscoverSearch() {
  const [search, setSearch] = useState("");
  const [searching, setSearching] = useState(false);
  const navigation = useNavigation();

  return (
    <View className={`flex items-center p-2 shadow-lg flex-row`}>
      <Text>This is a test</Text>
    </View>
  );
}
