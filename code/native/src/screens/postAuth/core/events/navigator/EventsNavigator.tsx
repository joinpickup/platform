import React, { useState } from "react";
import { View, useWindowDimensions, SafeAreaView } from "react-native";
import EventsAppBar from "../EventsAppBar";
import EventsFeed from "../EventsFeed";
import EventsFilterBar from "../EventsFilterBar";
import Event from "../../../../../models/event";

const upcoming: Event[] = [
  {
    id: 1,
    name: "Friendly Competition Time",
    description:
      "Andrew vs. Brian, who's going to win in a battle against the rocks.",
    start_time: new Date(),
    interests: [{ id: 1, name: "Climbing" }],
    location: {
      id: "1",
      common_name: "East Rock Climb",
    },
  },
  {
    id: 2,
    name: "Birthday Party",
    start_time: new Date(),
    description:
      "This is the birthday party of a limetime and you do not want to miss it.",
    interests: [{ id: 2, name: "Hanging-Out" }],
    location: {
      id: "2",
      common_name: "Andrew's Crib",
    },
  },
];

const saved: Event[] = [
  {
    id: 1,
    name: "Friendly Competition Time",
    description:
      "Andrew vs. Brian, who's going to win in a battle against the rocks.",
    start_time: new Date(),
    interests: [{ id: 1, name: "Climbing" }],
    location: {
      id: "1",
      common_name: "East Rock Climb",
    },
  },
];

export default function EventsNavigator() {
  const [activeFilter, setActiveFilter] = useState("upcoming");

  return (
    <SafeAreaView className="flex-col flex-1">
      <View>
        <EventsAppBar />
        <EventsFilterBar
          activeFilter={activeFilter}
          setActiveFilter={setActiveFilter}
        />
      </View>

      <EventsFeed events={getFeedDataFromFilter(activeFilter)} />
    </SafeAreaView>
  );
}

function getFeedDataFromFilter(filter: string): Event[] {
  switch (filter) {
    case "upcoming":
      return upcoming;
    case "saved":
      return saved;
    default:
      return upcoming;
  }
}
