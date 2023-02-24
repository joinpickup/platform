import React, { useState } from "react";
import { Pressable, View } from "react-native";

interface Props {
    press: Function;
    children: JSX.Element;
}

export default function IconButton({children, press}: Props) {
    const [selected, setSelected] = useState(false);

    return (
        <Pressable
        onPress={() => {
            press()
        }}
        onPressIn={() => {
            setSelected(true);
        }}
        onPressOut={() => {
            setSelected(false);
        }}
        >
            <View className={`p-2 rounded-lg ${selected ? "bg-gray-600" : ""}`}>
                {children}
            </View>
        </Pressable>
    )
}