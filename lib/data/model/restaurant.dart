class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus? menus;
  final String? address;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.menus,
    this.address,
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
        menus: json['menus'] != null ? Menus.fromJson(json['menus']) : null,
        address: json['address']?.toString(),
      );
    } catch (e) {
      throw FormatException('Failed to load Restaurant data: $e');
    }
  }
}

class Menus {
  final List<String> foods;
  final List<String> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods:
          (json['foods'] as List<dynamic>?)
              ?.map((item) => item['name'].toString())
              .toList() ??
          [],
      drinks:
          (json['drinks'] as List<dynamic>?)
              ?.map((item) => item['name'].toString())
              .toList() ??
          [],
    );
  }
}
