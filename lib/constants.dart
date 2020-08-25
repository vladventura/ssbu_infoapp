const String assets = "assets/";
const String extension = ".png";

String sliverPath({String character, String image: "0"}) {
  return assets + "Slivers/" + character + "_sliver_" + image + extension;
}

String stockPath({String character, String image: "0"}) {
  return assets + "Stock/" + character + "_stock_" + image + extension;
}

String seriesPath(String series) {
  return assets + "Series/" + series + extension;
}
