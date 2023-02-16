import React from "react";
import { View } from "react-native";
import DiscoverAppBar from "../../components/surfaces/appbars/DiscoverAppBar";
import MapboxGL from "@rnmapbox/maps";

MapboxGL.setAccessToken("pk.eyJ1Ijoiam9pbnBpY2t1cCIsImEiOiJjbGU3YWtuNG4wM2x4M3ZuMWF2bGY4dGFmIn0.PNtNIKARSJdGC94vcjf4Eg");

export default function PlacesScreen() {
  return (
    <View className="p-4 flex flex-col flex-1">
      <DiscoverAppBar />
      <View>
        <MapboxGL.MapView />
      </View>
    </View>
  );
}
