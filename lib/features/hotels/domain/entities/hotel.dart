import 'package:equatable/equatable.dart';

/// Entity representing a hotel
class Hotel extends Equatable {
  /// Unique identifier for the hotel
  final String id;

  /// Name of the hotel
  final String name;

  /// Description of the hotel
  final String description;

  /// URL or asset path to the hotel image
  final String imageUrl;

  /// Additional images of the hotel
  final List<String> additionalImages;

  /// Location of the hotel (city name)
  final String location;

  /// Address of the hotel
  final String address;

  /// Price per night (in USD)
  final double pricePerNight;

  /// Rating of the hotel (out of 5)
  final double rating;

  /// Number of stars (1-5)
  final int stars;

  /// Geographic coordinates of the hotel
  final Map<String, double> coordinates;

  /// Amenities offered by the hotel
  final List<String> amenities;

  /// Available room types
  final List<String> roomTypes;

  /// Contact information
  final String contactInfo;

  /// Website URL
  final String? websiteUrl;

  /// Creates a new [Hotel] instance
  const Hotel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.additionalImages = const [],
    required this.location,
    required this.address,
    required this.pricePerNight,
    required this.rating,
    required this.stars,
    required this.coordinates,
    this.amenities = const [],
    this.roomTypes = const [],
    required this.contactInfo,
    this.websiteUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        additionalImages,
        location,
        address,
        pricePerNight,
        rating,
        stars,
        coordinates,
        amenities,
        roomTypes,
        contactInfo,
        websiteUrl,
      ];
}
