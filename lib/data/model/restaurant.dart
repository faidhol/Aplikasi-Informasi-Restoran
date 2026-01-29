class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    try {
      final ratingValue = json['rating'];
      final double rating = (ratingValue is int)
          ? ratingValue.toDouble()
          : (ratingValue is num)
              ? ratingValue.toDouble()
              : double.tryParse(ratingValue.toString()) ?? 0.0;

      return Restaurant(
        id: json['id'].toString(),
        name: json['name']?.toString() ?? '',
        description: json['description']?.toString() ?? '',
        pictureId: json['pictureId']?.toString() ?? '',
        city: json['city']?.toString() ?? '',
        rating: rating,
      );
    } catch (e) {
      throw FormatException('Failed to load Restaurant data: $e');
    }
  }
}
