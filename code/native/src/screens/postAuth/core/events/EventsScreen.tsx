import React, {useState} from "react";
import { Pressable, TouchableOpacity, View, RefreshControl, ScrollView } from "react-native";
import { useNavigation } from "@react-navigation/native";
import Card from "../../../../components/surfaces/cards/Card";
import EventCard from "../../../../components/surfaces/cards/EventCard";
import Event from "../../../../models/event";

const data: Event[] = [
  {
    id: 1,
    name: "Friendly Competition Time",
    description: "Andrew vs. Brian, who's going to win in a battle against the rocks.",
    start_time: new Date(),
    interests: [
      {id: 1, name: "Climbing"},
    ],
    location: {
      id: "1",
      common_name: "East Rock Climb"
    },
  },
  {
    id: 2,
    name: "Birthday Party",
    start_time: new Date(),
    description: "This is the birthday party of a limetime and you do not want to miss it.",
    interests: [
      {id: 2, name: "Hanging-Out"},
    ],
    location: {
      id: "2",
      common_name: "Andrew's Crib"
    },
  }
];

export default function EventsScreen() {
  const navigator = useNavigation();
  const [refreshing, setRefreshing] = useState(false);

  const onRefresh = React.useCallback(() => {
    setRefreshing(true);
    setTimeout(() => {
      setRefreshing(false);
    }, 1000);
  }, []);

  return (
    <ScrollView 
    className="flex-1 bg-gray-600 px-2"
    refreshControl={
      <RefreshControl 
        refreshing={refreshing} 
        onRefresh={onRefresh} 
        tintColor="#d1d5db"
      />
    }
    >
      <View className="flex py-2 flex-col space-y-2">
        {data.map((event) => {
          return (
            <View key={event.id}>
              <Pressable
                onPress={() => {
                  navigator.push("EventScreen", {id: event.id})
                }}
              >
                <EventCard event={event}/>
              </Pressable>
            </View>
          );
        })}
      </View>
    </ScrollView>
  );
}