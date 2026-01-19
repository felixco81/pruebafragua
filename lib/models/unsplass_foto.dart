class UnsplashPhoto {
  final String id;
  final String description;
  final String imageUrl;
  final String thumbnailUrl;

  UnsplashPhoto({
    required this.id,
    required this.description,
    required this.imageUrl,
      required this.thumbnailUrl,
  });

  factory UnsplashPhoto.fromMap(Map<String, dynamic> map) {
    return UnsplashPhoto(
      id: map['id'],
      description: map['alt_description'] ?? map['description'] ?? '',
      imageUrl: map['urls']['regular'],
      thumbnailUrl : map['urls']['thumb']
    );
  }
}