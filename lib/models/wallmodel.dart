class PhotosModel {
  String url;
  String category;

  PhotosModel({this.url, this.category,});
  factory PhotosModel.fromMap(Map<String, dynamic> parsedJson) {
    return PhotosModel(
      url: parsedJson["url"],
      category: parsedJson["category"],
    );
  }

}