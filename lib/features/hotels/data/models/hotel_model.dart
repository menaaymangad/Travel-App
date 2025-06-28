import '../../domain/entities/hotel.dart';

/// Data model for a hotel
class HotelModel extends Hotel {
  /// Creates a new [HotelModel] instance
  const HotelModel({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    List<String> additionalImages = const [],
    required String location,
    required String address,
    required double pricePerNight,
    required double rating,
    required int stars,
    required Map<String, double> coordinates,
    List<String> amenities = const [],
    List<String> roomTypes = const [],
    required String contactInfo,
    String? websiteUrl,
  }) : super(
          id: id,
          name: name,
          description: description,
          imageUrl: imageUrl,
          additionalImages: additionalImages,
          location: location,
          address: address,
          pricePerNight: pricePerNight,
          rating: rating,
          stars: stars,
          coordinates: coordinates,
          amenities: amenities,
          roomTypes: roomTypes,
          contactInfo: contactInfo,
          websiteUrl: websiteUrl,
        );

  /// Creates a [HotelModel] from a JSON map
  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      additionalImages: json['additionalImages'] != null
          ? List<String>.from(json['additionalImages'] as List)
          : const [],
      location: json['location'] as String,
      address: json['address'] as String,
      pricePerNight: (json['pricePerNight'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      stars: json['stars'] as int,
      coordinates: Map<String, double>.from(json['coordinates'] as Map),
      amenities: json['amenities'] != null
          ? List<String>.from(json['amenities'] as List)
          : const [],
      roomTypes: json['roomTypes'] != null
          ? List<String>.from(json['roomTypes'] as List)
          : const [],
      contactInfo: json['contactInfo'] as String,
      websiteUrl: json['websiteUrl'] as String?,
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
      'pricePerNight': pricePerNight,
      'rating': rating,
      'stars': stars,
      'coordinates': coordinates,
      'amenities': amenities,
      'roomTypes': roomTypes,
      'contactInfo': contactInfo,
      'websiteUrl': websiteUrl,
    };
  }
}
