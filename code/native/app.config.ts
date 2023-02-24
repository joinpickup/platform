import { ExpoConfig, ConfigContext } from "expo/config";

export default ({ config }: ConfigContext): ExpoConfig => ({
  ...config,
  slug: "local",
  name: "Local",
  orientation: "portrait",
  splash: {
    image: "./src/assets/splash.png",
    backgroundColor: "#374151",
  },
  ios: {
    bundleIdentifier: "com.joinpickup.local",
  },
  plugins: [],
});
