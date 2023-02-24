import { useNavigation } from "@react-navigation/native";
import React, { useState } from "react";
import { Pressable, Text, View } from "react-native";
import Post from "../../../models/post";
import { Colors } from "../../../styles/theme";
import { getTimeSince } from "../../../util/date";

type Props = {
  post: Post;
};

export default function PostCard({ post }: Props) {
  const navigator = useNavigation();
  const [selected, setSelected] = useState(false);

  return (
    <Pressable
      onPressIn={() => {
        setSelected(true);
      }}
      onPressOut={() => {
        setSelected(false);
      }}
      onPress={() => {
        navigator.push("PostScreen", { id: post.id });
      }}
    >
    <View className={`${selected ? "bg-gray-800" : "bg-gray-700"} flex-col space-y-2 p-4 rounded-lg`}>
      <View className="flex-row space-x-2 items-center">
        <View className="h-12 w-12 bg-blue-400 rounded-full"></View>
        <View className="flex flex-col">
          <View className="flex-row space-x-2 items-center">
            <View>
              <Text
                style={{
                  fontFamily: "Nunito-Bold",
                }}
                className="text-gray-300 text-lg"
              >
                {post?.poster?.name}
              </Text>
            </View>
          </View>
          <View className="flex-row space-x-2 items-center">
            <View>
              <Text
                style={{
                  fontFamily: "Nunito-Bold",
                  color: Colors.gray[400],
                }}
              >
                {post?.location?.common_name}
              </Text>
            </View>
            <View className="bg-orange rounded-full h-1 w-1"></View>
            <View>
              <Text
                style={{
                  fontFamily: "Nunito-Bold",
                }}
                className="text-gray-400 font-bold"
              >
                {post?.visibility.toLowerCase()}
              </Text>
            </View>
          </View>
        </View>
      </View>
      <View className="">
        <Text
          style={{
            fontFamily: "Nunito-Bold",
            color: Colors.gray[300],
          }}
          className="text-xl"
        >
          {post?.title}
        </Text>
        <Text
          style={{
            fontFamily: "Nunito-SemiBold",
            color: Colors.gray[400],
          }}
        >
          {post?.body}
        </Text>
      </View>
      <View className="flex-row justify-between">
        <View className="flex-row space-x-2">
          {post?.interests?.map((interest) => {
            return (
              <View className="" key={interest.id}>
                <Text
                  style={{
                    fontFamily: "Nunito-Bold",
                  }}
                  className="text-orange-500 font-bold"
                >
                  #{interest?.name}
                </Text>
              </View>
            );
          })}
        </View>
        <Text
          style={{
            fontFamily: "Nunito-Bold",
            color: Colors.gray[400],
          }}
        >
          {getTimeSince(new Date(post?.created_at))}
        </Text>
      </View>
    </View>
  </Pressable>
  );
}
