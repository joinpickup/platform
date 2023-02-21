import colors from "tailwindcss/colors"
import { DefaultTheme } from "@react-navigation/native";

export const Colors = {
    gray: {
        ...colors.gray
    },
    orange: {
        DEFAULT: "#D3733C",
        100: "#FEEADE",
        200: "#FCC3A3",
        300: "#F9A373",
        400: "#E88954",
        500: "#D3733C",
        600: "#AB4A13",
        700: "#933D0D",
        800: "#772F06",
        900: "#4F1C00",
    },
    green: {
        DEFAULT: "#5A6943",
        100: "#DCE2D1",
        200: "#C7D4B1",
        300: "#ACBB93",
        400: "#91A078",
        500: "#6B7954",
        600: "#5A6943",
        700: "#46552F",
        800: "#374620",
        900: "#243110",
    },
} 
export const DarkMode: Theme = {
    ...DefaultTheme,
    colors: {
      primary: '#5A6943',
      background: '#374151',
      card: '#64748b',
      text: '#d1d5db',
      border: '#374151',
      notification: DefaultTheme.colors.notification
    },
  };