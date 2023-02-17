import React from "react";
import { SafeAreaView, Text, View } from "react-native";
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { LoginPage } from "../src/screens/preAuth/login/LoginScreen";
import { RegisterPage } from "../src/screens/preAuth/register/RegisterPage";

const Stack = createNativeStackNavigator();

export function PreAuthNavigator() {
    return (
        <Stack.Navigator initialRouteName="Login">
            <Stack.Screen name="Login" component={LoginPage} />
            <Stack.Screen name="Register" component={RegisterPage} />
        </Stack.Navigator>
    )
} 