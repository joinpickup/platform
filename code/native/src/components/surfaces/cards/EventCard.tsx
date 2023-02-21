import { formatDuration } from "date-fns";
import React, { useEffect } from "react";
import { Text, View } from "react-native";
import Event from "../../../models/event";
import Interest from "../../../models/interest";
import Post from "../../../models/post";
import { Colors } from "../../../styles/theme";
import { getTimeSince } from "../../../util/date";
import BaseText from "../../text/BaseText";

type Props = {
    event: Event
}

export default function EventCard({event}: Props) {
    return (
        <View className="flex-col space-y-2 bg-gray-700 p-4 rounded-lg">
            <View className="flex-col">
                <View>
                    <Text 
                    style={{fontFamily: "Nunito-Bold"}}
                    className="text-xl text-gray-300 font-bold">{event?.name}</Text>
                    <Text 
                    style={{fontFamily: "Nunito-BoldItalic"}}
                    className="text-base text-orange-500 font-bold">{event?.location?.common_name}</Text>
                </View>
            </View>
            <View>
                <Text 
                style={{
                    fontFamily: "Nunito-Bold"
                }}
                className="text-gray-300">{event?.description}</Text>
            </View>
            <View className="flex-row justify-between">
                <View className="flex-row space-x-2">
                    {event?.interests?.map(interest => {
                        return (
                            <View className="" key={interest.id}>
                                <Text
                                    style={{
                                        fontFamily: "Nunito-Bold"
                                    }}
                                    className="text-orange-500 font-bold"
                                >
                                    #{interest?.name}
                                </Text>
                            </View>
                        )
                    })}
                </View>
                <View className="flex-row space-x-2 items-center">
                    <Text 
                    style={{fontFamily: "Nunito-Bold"}}
                    className="text-sm text-gray-400 font-bold">{new Date().toDateString()}</Text>
                    <View className="h-1 w-1 rounded-full bg-orange"></View>
                    <Text 
                    style={{fontFamily: "Nunito-Bold"}}
                    className="text-sm text-gray-400 font-bold">2:30PM</Text>
                </View>
            </View>
        </View>
    )
}