class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menu? menus;
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
    final ratingValue = json['rating'];

    final double rating = (ratingValue is num)
        ? ratingValue.toDouble()
        : double.tryParse(ratingValue?.toString() ?? '') ?? 0.0;

    return Restaurant(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      pictureId: json['pictureId']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      rating: rating,
      menus: json['menus'] != null ? Menu.fromJson(json['menus']) : null,
      address: json['address']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
      'address': address,
    };
  }

  factory Restaurant.empty() {
    return Restaurant(
      id: '',
      name: '',
      description: '',
      pictureId: '',
      city: '',
      rating: 0.0,
      address: '',
      menus: null,
    );
  }
}

class Menu {
  final List<String> foods;
  final List<String> drinks;

  Menu({required this.foods, required this.drinks});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
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
