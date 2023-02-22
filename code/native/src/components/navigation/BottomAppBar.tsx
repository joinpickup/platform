import React from "react";
import { Text, TouchableOpacity, View, SafeAreaView } from "react-native";
import Events from "../icons/Events";
import HomeSolid from "../icons/home/HomeSolid";
import Places from "../icons/Places";
import ProfileSolid from "../icons/profile/ProfileSolid";
import BaseText from "../text/BaseText";

type Props = {
  tab: number;
  setTab: (v: number) => void;
};

export default function BottomAppBar(props: Props) {
  return (
    <SafeAreaView className="bg-gray-700">
      <View className="flex rounded-lg w-screen p-2 px-4 flex-row justify-between">
        <BottomAppBarItem
          icon={<HomeSolid className="text-gray-300" />}
          text="Home"
          tab={0}
          current={props.tab}
          setTab={props.setTab}
        />
        <BottomAppBarItem
          icon={<Places className="text-gray-300" />}
          text="Places"
          current={props.tab}
          tab={1}
          setTab={props.setTab}
        />
        <BottomAppBarItem
          icon={<Events className="text-gray-300" />}
          text="Events"
          tab={2}
          current={props.tab}
          setTab={props.setTab}
        />
        <BottomAppBarItem
          icon={<ProfileSolid className="text-gray-300" />}
          text="Profile"
          tab={3}
          current={props.tab}
          setTab={props.setTab}
        />
      </View>
    </SafeAreaView>
  );
}

type BottomAppBarItem = {
  icon: JSX.Element;
  current: number;
  text: string;
  tab: number;
  setTab: (v: number) => void;
};

function BottomAppBarItem(props: BottomAppBarItem) {
  return (
    <TouchableOpacity
      onPress={() => {
        props.setTab(props.tab);
      }}
    >
      <View
        className={`flex flex-col items-center p-2 rounded-lg space-y-2 ${
          props.tab == props.current ? "bg-gray-500" : ""
        }`}
      >
        {props.icon}
        <BaseText className="text-gray-300">{props.text}</BaseText>
      </View>
    </TouchableOpacity>
  );
}
