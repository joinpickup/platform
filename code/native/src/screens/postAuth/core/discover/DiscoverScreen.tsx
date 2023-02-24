import { useNavigation } from "@react-navigation/native";
import React, { useState } from "react";
import {
  Pressable,
  RefreshControl,
  TouchableOpacity,
  View,
  ScrollView,
} from "react-native";
import Card from "../../../../components/surfaces/cards/Card";
import PostCard from "../../../../components/surfaces/cards/PostCard";
import Post from "../../../../models/post";
import { Visibility } from "../../../../models/visibility";

const data: Post[] = [
  {
    id: 1,
    created_at: new Date(),
    poster: {
      username: "andyrewco",
      name: "Andrew",
    },
    title: "Looking for a Belay Partner",
    body: "Here is some more info about me...",
    interests: [{ id: 2, name: "Rock-Climbing" }],
    location: {
      id: "1",
      common_name: "East Rock",
    },
    visibility: Visibility.PUBLIC,
  },
  {
    id: 2,
    created_at: new Date(),
    poster: {
      username: "windswept",
      name: "Brian",
    },
    title: "Looking to go on a midnight hike",
    body: "Let me know what you think!!...",
    interests: [{ id: 1, name: "Hiking" }],
    location: {
      id: "1",
      common_name: "East Rock",
    },
    visibility: Visibility.PRIVATE,
  },
];

export default function DiscoverScreen() {
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
        {data.map((post) => {
          return (
            <View key={post.id}>
                <PostCard post={post} />
            </View>
          );
        })}
      </View>
    </ScrollView>
  );
}
