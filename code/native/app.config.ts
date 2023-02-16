import { ExpoConfig, ConfigContext } from "expo/config";

export default ({ config }: ConfigContext): ExpoConfig => ({
  ...config,
  slug: "local",
  name: "Local",
  orientation: "portrait",
  plugins: [
    [
      "@rnmapbox/maps",
      {
        RNMapboxMapsImpl: "maplibre",
      },
    ],
  ],
  ios: {
    "bundleIdentifier": "com.joinpickup.local"
  },
  extra: {
    "eas": {
      "projectId": "d298ec72-4d4f-4a4d-ba2f-c10a454985f6"
    }
  }
});
