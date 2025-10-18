class Product {
  final int id;
  final String name;
  final String brand;
  final String category; // 'Уходовая', 'Декоративная', 'Парфюмерия'
  final String volume;   // напр., "50 мл"
  final String expirationDate; // напр., "12.2026"
  final double rating;   // 1..5
  final bool isFavorite;

  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.volume,
    required this.expirationDate,
    required this.rating,
    required this.isFavorite,
  });

  Product copyWith({
    int? id,
    String? name,
    String? brand,
    String? category,
    String? volume,
    String? expirationDate,
    double? rating,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      volume: volume ?? this.volume,
      expirationDate: expirationDate ?? this.expirationDate,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
