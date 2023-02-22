import { ExpoConfig, ConfigContext } from "expo/config";

export default ({ config }: ConfigContext): ExpoConfig => ({
  ...config,
  slug: "local",
  name: "Local",
  orientation: "portrait",
  ios: {
    "bundleIdentifier": "com.joinpickup.local"
  },
  plugins: []
});
