const path = require("path");

module.exports = {
  mode: "development",
  entry: {
    app: "./index.js"
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
        exclude: /(node_modules|bower_components)/,
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
    noInfo: true,
    port: 5000
  },
  context: __dirname,
  target: "web",
  plugins: []
};
