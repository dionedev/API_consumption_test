class ProductModel {
  final String title;
  final String description;
  final String category;
  final double price;
  final double rating;
  final String brand;
  final List<String> images;
  final String thumbnail;

  ProductModel({
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.brand,
    required this.images,
    required this.thumbnail,
  });

  factory ProductModel.fromMap(Map<String, dynamic> json) {
    return ProductModel(
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: json['price'] * 1.0,
      rating: json['rating'] * 1.0,
      brand: json['brand'],
      images: List<String>.from((json['images'] as List)),
      thumbnail: json['thumbnail'],
    );
  }
}
