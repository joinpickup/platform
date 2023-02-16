import React, { useState } from "react";
import {
  TextInput,
  Text,
  TouchableOpacity,
  View,
  Keyboard,
} from "react-native";
import Close from "../../icons/Close";
import Group from "../../icons/Group";
import More from "../../icons/More";
import Search from "../../icons/Search";

export default function DiscoverAppBar() {
  const [search, setSearch] = useState("");
  const [searching, setSearching] = useState(false);

  return (
    <View className={`flex items-center pb-4 flex-row`}>
      {searching ? (
        <></>
      ) : (
        <View className="p-2">
          <TouchableOpacity>
            <Group className="text-gray-300" />
          </TouchableOpacity>
        </View>
      )}
      <View className="flex-row space-x-2 items-center flex-1 h-8 px-2 font-bold bg-gray-500 rounded-lg ">
        <Search className="text-gray-300" />
        <TextInput
          className="flex-1 h-full placeholder:text-gray-300 placeholder:font-bold"
          onFocus={() => setSearching(true)}
          onBlur={() => setSearching(false)}
          placeholder="Search for posts.."
          selectionColor={"#5A6943"}
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
            <Text className="text-sm text-gray-300 font-bold">Close</Text>
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
