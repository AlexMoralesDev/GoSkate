/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./app/**/*.{js,jsx,ts,tsx}", "./components/**/*.{js,jsx,ts,tsx}"],
  theme: {
    extend: {
      colors: {
        thrasher: {
          red: "#D60C0C",
          black: "#000000",
          white: "#FFFFFF",
          grey: "#2A2A2A",
        },
      },
      fontFamily: {
        thrasher: ["Impact", "sans-serif"],
      },
    },
  },
  plugins: [],
};
