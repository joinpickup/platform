import React from 'react';
import MapView from 'react-native-maps';
import { StyleSheet, View } from 'react-native';

export default function PlacesScreen() {
  return (
    <View className="flex-1">
      <MapView className="w-full h-full"/>
    </View>
  );
}