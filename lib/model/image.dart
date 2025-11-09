class ImageResposnse {
  ImageResposnse({
    required this.url,
  });

  final String? url;

  factory ImageResposnse.fromJson(Map<String, dynamic> json) {
    return ImageResposnse(
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
