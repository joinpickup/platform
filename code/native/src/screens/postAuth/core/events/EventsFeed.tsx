import React, { useCallback, useState } from "react";
import {
  Pressable,
  TouchableOpacity,
  View,
  RefreshControl,
  ScrollView,
} from "react-native";
import { useNavigation } from "@react-navigation/native";
import Card from "../../../../components/surfaces/cards/Card";
import EventCard from "../../../../components/surfaces/cards/EventCard";
import Event from "../../../../models/event";

interface Props {
  events: Event[];
}

export default function EventsFeed({ events }: Props) {
  const navigator = useNavigation();
  const [refreshing, setRefreshing] = useState(false);

  const onRefresh = useCallback(() => {
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
      <View className="flex pb-2 flex-col space-y-2">
        {events.map((event) => {
          return (
            <View key={event.id}>
              <EventCard event={event} />
            </View>
          );
        })}
      </View>
    </ScrollView>
  );
}
