import '../../domain/entities/restaurant.dart';

/// Data model for a restaurant
class RestaurantModel extends Restaurant {
  /// Creates a new [RestaurantModel] instance
  const RestaurantModel({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    List<String> additionalImages = const [],
    required String location,
    required String address,
    required double averagePrice,
    required double rating,
    required Map<String, double> coordinates,
    List<String> cuisineTypes = const [],
    Map<String, String> openingHours = const {},
    required String contactInfo,
    String? websiteUrl,
    bool hasDelivery = false,
    bool hasTakeaway = false,
    bool hasReservations = false,
  }) : super(
          id: id,
          name: name,
          description: description,
          imageUrl: imageUrl,
          additionalImages: additionalImages,
          location: location,
          address: address,
          averagePrice: averagePrice,
          rating: rating,
          coordinates: coordinates,
          cuisineTypes: cuisineTypes,
          openingHours: openingHours,
          contactInfo: contactInfo,
          websiteUrl: websiteUrl,
          hasDelivery: hasDelivery,
          hasTakeaway: hasTakeaway,
          hasReservations: hasReservations,
        );

  /// Creates a [RestaurantModel] from a JSON map
  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      additionalImages: json['additionalImages'] != null
          ? List<String>.from(json['additionalImages'] as List)
          : const [],
      location: json['location'] as String,
      address: json['address'] as String,
      averagePrice: (json['averagePrice'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      coordinates: Map<String, double>.from(json['coordinates'] as Map),
      cuisineTypes: json['cuisineTypes'] != null
          ? List<String>.from(json['cuisineTypes'] as List)
          : const [],
      openingHours: json['openingHours'] != null
          ? Map<String, String>.from(json['openingHours'] as Map)
          : const {},
      contactInfo: json['contactInfo'] as String,
      websiteUrl: json['websiteUrl'] as String?,
      hasDelivery: json['hasDelivery'] as bool? ?? false,
      hasTakeaway: json['hasTakeaway'] as bool? ?? false,
      hasReservations: json['hasReservations'] as bool? ?? false,
    );
  }

  /// Converts this model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'additionalImages': additionalImages,
      'location': location,
      'address': address,
      'averagePrice': averagePrice,
      'rating': rating,
      'coordinates': coordinates,
      'cuisineTypes': cuisineTypes,
      'openingHours': openingHours,
      'contactInfo': contactInfo,
      'websiteUrl': websiteUrl,
      'hasDelivery': hasDelivery,
      'hasTakeaway': hasTakeaway,
      'hasReservations': hasReservations,
    };
  }
}
