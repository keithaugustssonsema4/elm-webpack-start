const path = require("path");

module.exports = {
  mode: "development",
  entry: {
    helloWorld: "./src/helloWorld.js",
    todo: "./src/todo.js"
  },
  output: {
    path: path.resolve(__dirname, "public/dist"),
    filename: "[name].js",
    publicPath: "/assets/"
  },
  module: {
    rules: [
      {
        test: /\.m?js$/,
        exclude: /(node_modules)/,
        use: {
          loader: "babel-loader",
          options: {
            presets: ["@babel/preset-env"]
          }
        }
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: [
          { loader: "elm-hot-webpack-loader" },
          {
            loader: "elm-webpack-loader",
            options: {}
          }
        ]
      },
      {
        test: /\.scss$/,
        use: [
          "style-loader",
          "css-loader",
          {
            loader: "sass-loader",
            options: {
              implementation: require("sass")
            }
          }
        ]
      }
    ]
  },
  devtool: "source-map",
  devServer: {
    contentBase: [path.join(__dirname, "public")],
    compress: true,
    historyApiFallback: true,
    hot: true,
    https: false,
    port: 5000
  },
  context: __dirname,
  target: "web",
  plugins: []
};
