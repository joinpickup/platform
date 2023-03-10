import { useNavigation } from "@react-navigation/native";
import React, { useState } from "react";
import {
  TextInput,
  Text,
  TouchableOpacity,
  View,
  Keyboard,
} from "react-native";
import AddSolid from "../../../../components/icons/add/AddSolid";
import Close from "../../../../components/icons/Close";
import Group from "../../../../components/icons/Group";
import HomeSolid from "../../../../components/icons/home/HomeSolid";
import More from "../../../../components/icons/More";
import Search from "../../../../components/icons/Search";
import IconButton from "../../../../components/input/IconButton";
import style from "../../../../styles/style";

export default function DiscoverAppBar() {
  const [search, setSearch] = useState("");
  const [searching, setSearching] = useState(false);
  const navigation = useNavigation();

  return (
    <View
      className={`flex font-sans-serif items-center p-2 shadow-lg flex-row`}
    >
      {searching ? (
        <></>
      ) : (
        <View className="p-2">
          <IconButton press={() => {}}>
            <Group className="text-gray-300" />
          </IconButton>
        </View>
      )}
      <View className="flex-row space-x-2 items-center flex-1 h-8 px-2 font-bold bg-gray-600 rounded-lg ">
        <Search className="text-gray-300" />
        <TextInput
          className="flex-1 h-full placeholder:text-gray-300 placeholder:font-bold"
          onFocus={() => setSearching(true)}
          onBlur={() => setSearching(false)}
          placeholder="Search for posts.."
          selectionColor="#D3733C"
          placeholderTextColor="#9ca3af"
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
          <IconButton press={() => {}}>
            <AddSolid className="text-gray-300"/>
          </IconButton>
        </View>
      )}
    </View>
  );
}
