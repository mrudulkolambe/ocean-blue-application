class GalleryResponse {
  bool error;
  String message;
  List<Gallery> gallery;

  GalleryResponse({
    required this.error,
    required this.message,
    required this.gallery,
  });

  factory GalleryResponse.fromJson(dynamic json) {
    final error = json["error"] as bool;
    final message = json["message"] as String;
    final gallery = List.from(json["response"]).map((e) {
      return Gallery.fromJson(e);
    }).toList();
    return GalleryResponse(
      error: error,
      message: message,
      gallery: gallery,
    );
  }
}

class Gallery {
  String id;
  String url;
  String type;

  Gallery({
    required this.id,
    required this.url,
    required this.type,
  });

  factory Gallery.fromJson(dynamic json) {
    final id = json["_id"] as String;
    final url = json["url"] as String;
    final type = json["type"] as String;
    return Gallery(
      id: id,
      url: url,
      type: type,
    );
  }
}
