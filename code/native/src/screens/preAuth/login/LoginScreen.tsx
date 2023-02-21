import {
  NavigationProp,
  ParamListBase,
  useNavigation,
} from "@react-navigation/native";
import { NativeStackNavigationProp } from "@react-navigation/native-stack";
import React from "react";
import { Button, SafeAreaView, Text } from "react-native";

export function LoginPage() {
  const navigation = useNavigation<NativeStackNavigationProp<any>>();
  return (
    <SafeAreaView>
      <Text>Login Page</Text>
      <Button
        title="Register"
        onPress={() => {
          navigation.push("Register");
        }}
      ></Button>
    </SafeAreaView>
  );
}
