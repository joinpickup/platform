import React from "react";
import { createDrawerNavigator } from "@react-navigation/drawer";

const Drawer = createDrawerNavigator();

export default function BoardNavigator() {
    return (
        <Drawer.Navigator initialRouteName="Home">
        </Drawer.Navigator>
    )
}