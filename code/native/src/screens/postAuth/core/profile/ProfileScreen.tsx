import React, { useEffect, useState } from "react";
import { SafeAreaView, ScrollView, View, Text, Pressable } from "react-native";
import Home from "../../../../components/icons/Home";
import ProfileBody from "./ProfileBody";

interface Setting {
  icon: JSX.Element;
  name: string;
}

interface SettingGroup {
  name: string;
  settings: Setting[];
}

const accountSettings: SettingGroup = {
  name: "Account",
  settings: [
    {
      icon: <Home 
        className="text-gray-300"
      />,
      name: "Profile"
    },
    {
      icon: <Home 
        className="text-gray-300"
      />,
      name: "Home"
    },
  ]
}

const appSettings: SettingGroup = {
  name: "Application",
  settings: [
    {
      icon: <Home 
        className="text-gray-300"
      />,
      name: "Profile"
    },
    {
      icon: <Home 
        className="text-gray-300"
      />,
      name: "Home"
    },
  ]
}

const allSettings: SettingGroup[] = [
  accountSettings, appSettings
]

export default function ProfileScreen() {
  return (
    <SafeAreaView className="flex flex-col flex-1">
      <ScrollView className="flex-1 p-4">
        <ProfileSettings groups={allSettings} />
      </ScrollView>
    </SafeAreaView>
  );
}

interface ProfileSettingsProps {
  groups: SettingGroup[]
}

function ProfileSettings(props: ProfileSettingsProps) {
  return (
    <View className="flex-col space-y-4">
      {props.groups.map(group => {
        return (
          <View key={group.name} className="flex-col space-y-2">
            <View>
              <Text 
                style={{fontFamily: "Nunito-Bold"}}
                className="text-gray-300 text-xl">{group.name}</Text>
            </View>
            <View className="flex-col space-y-2 rounded-lg p-2 bg-gray-600">
              <SettingGroup settings={group.settings} />
            </View>
          </View>
        )
      })}
    </View>
  )
}

interface SettingGroupProps {
  settings: Setting[] 
}

function SettingGroup(props: SettingGroupProps) {
  return (
    <View className="flex-col space-y-1 divide-gray-700 rounded-lg">
      {props.settings.map(setting => {
        return (
          <View key={setting.name} >
            <SettingItem setting={setting} />
          </View>
        )
      })}
    </View>
  )

}

interface SettingItemProps {
  setting: Setting
}

function SettingItem(props: SettingItemProps) {
  const [selected, setSelected] = useState(false);
  return (
    <Pressable onPressIn={() => {
      setSelected(true)
    }} onPressOut={() => {
      setSelected(false)
    }}>
      <View key={props.setting.name} className={`${selected ? "bg-gray-700" : ""} rounded-lg p-2 flex-row space-x-2 items-center`}>
        <View>
          {props.setting.icon}
        </View>
        <View>
          <Text
            style={{
              fontFamily: "Nunito-Bold"
            }}
            className="text-lg text-gray-300"
          >{props.setting.name}</Text>
        </View>
      </View>
    </Pressable>
  )
}
