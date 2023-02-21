import { useNavigation } from "@react-navigation/native";
import React, { useState } from "react";
import {
  TextInput,
  Text,
  TouchableOpacity,
  View,
  Keyboard,
} from "react-native";
import Close from "../../../../components/icons/Close";
import Group from "../../../../components/icons/Group";
import More from "../../../../components/icons/More";
import Search from "../../../../components/icons/Search";
import style from "../../../../styles/style"
import { Colors } from "../../../../styles/theme";

export default function EventsAppBar() {
  const [search, setSearch] = useState("");
  const [searching, setSearching] = useState(false);
  const navigation = useNavigation();

  return (
    <View className={`flex font-sans-serif items-center p-2 shadow-lg flex-row`}>
      {searching ? (
        <></>
      ) : (
        <View className="p-2">
          <TouchableOpacity onPress={() => {
          }}>
            <Group className="text-gray-300" />
          </TouchableOpacity>
        </View>
      )}
      <View className="flex-row space-x-2 items-center flex-1 h-8 px-2 font-bold bg-gray-600 rounded-lg ">
        <Search className="text-gray-300" />
        <TextInput
          className="flex-1 h-full placeholder:text-gray-300 placeholder:font-bold"
          onFocus={() => setSearching(true)}
          onBlur={() => setSearching(false)}
          placeholder="Search for events.."
          selectionColor={Colors.orange.DEFAULT}
          placeholderTextColor={Colors.gray["400"]}
          value={search}
          onChangeText={setSearch}
        />
        {searching && search ? (
          <TouchableOpacity
            onPress={() => {
              setSearch("");
            }}
          >
            <Close className="text-gray-300" />
          </TouchableOpacity>
        ) : (
          <></>
        )}
      </View>
      {searching ? (
        <View className="p-2">
          <TouchableOpacity
            onPress={() => {
              Keyboard.dismiss();
              setSearch("");
              setSearching(false);
            }}
          >
            <Text className="text-sm p-1 text-gray-300 font-bold">Close</Text>
          </TouchableOpacity>
        </View>
      ) : (
        <View className="p-2">
          <TouchableOpacity>
            <More className="text-gray-300" />
          </TouchableOpacity>
        </View>
      )}
    </View>
  );
}
