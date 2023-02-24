import { useNavigation } from "@react-navigation/native";
import React, { useState } from "react";
import { Text, View, ScrollView, Pressable } from "react-native";

interface Option {
  name: string;
  key: string;
  restricted: boolean;
}

const options: Option[] = [
  {
    name: "Upcoming",
    key: "upcoming",
    restricted: false,
  },
  {
    name: "Saved",
    key: "saved",
    restricted: false,
  },
  {
    name: "Organized",
    key: "organized",
    restricted: false,
  },
  {
    name: "Premium",
    key: "premium",
    restricted: true,
  },
];

interface Props {
  activeFilter: string;
  setActiveFilter: Function;
}

export default function EventsFilterBar({
  activeFilter,
  setActiveFilter,
}: Props) {
  const [active, setActive] = useState(activeFilter);

  return (
    <View className="p-2 bg-gray-600 ">
      <ScrollView horizontal={true} showsHorizontalScrollIndicator={false}>
        {options.map((option) => {
          return (
            <TabItem
              key={option.key}
              option={option}
              activeKey={active}
              setActive={(e) => {
                setActive(e);
                setActiveFilter(e);
              }}
            />
          );
        })}
      </ScrollView>
    </View>
  );
}

interface TabItemProps {
  option: Option;
  activeKey: string;
  setActive: Function;
}

function TabItem({ option, activeKey, setActive }: TabItemProps) {
  const [selected, setSelected] = useState(false);

  return (
    <Pressable
      key={option.key}
      onPressIn={() => {
        setSelected(true);
      }}
      onPressOut={() => {
        setSelected(false);
      }}
      onPress={() => setActive(option.key)}
    >
      <View
        className={`
        ${selected ? "bg-gray-500" : ""}
        ${
          activeKey == option.key
            ? "bg-gray-700 border-gray-700"
            : "border-gray-500"
        } mr-2 p-2 rounded-lg border`}
      >
        <Text
          style={{
            fontFamily: "Nunito-Bold",
          }}
          className="text-gray-300"
        >
          {option.name}
        </Text>
      </View>
    </Pressable>
  );
}
