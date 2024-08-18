const defaultTheme = require("tailwindcss/defaultTheme");
const colors = require("tailwindcss/colors");

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
  ],
  theme: {
    colors: {
      ...colors,
      primary: {
        DEFAULT: colors.teal[500], // #2DD4BF
        dark: colors.teal[600], // #0D9488
        light: colors.teal[400], // #99F6E4
      },
      secondary: {
        DEFAULT: colors.indigo[500], // #6366F1
        dark: colors.indigo[600], // #4F46E5
        light: colors.indigo[200], // #C7D2FE
      },
    },
    extend: {
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
  ],
};
