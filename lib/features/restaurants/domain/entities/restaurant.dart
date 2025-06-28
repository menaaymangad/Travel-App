import 'package:equatable/equatable.dart';

/// Entity representing a restaurant
class Restaurant extends Equatable {
  /// Unique identifier for the restaurant
  final String id;

  /// Name of the restaurant
  final String name;

  /// Description of the restaurant
  final String description;

  /// URL or asset path to the restaurant image
  final String imageUrl;

  /// Additional images of the restaurant
  final List<String> additionalImages;

  /// Location of the restaurant (city name)
  final String location;

  /// Address of the restaurant
  final String address;

  /// Average price per person (in USD)
  final double averagePrice;

  /// Rating of the restaurant (out of 5)
  final double rating;

  /// Geographic coordinates of the restaurant
  final Map<String, double> coordinates;

  /// Cuisine types offered by the restaurant
  final List<String> cuisineTypes;

  /// Opening hours
  final Map<String, String> openingHours;

  /// Contact information
  final String contactInfo;

  /// Website URL
  final String? websiteUrl;

  /// Whether the restaurant offers delivery
  final bool hasDelivery;

  /// Whether the restaurant offers takeaway
  final bool hasTakeaway;

  /// Whether the restaurant offers reservations
  final bool hasReservations;

  /// Creates a new [Restaurant] instance
  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.additionalImages = const [],
    required this.location,
    required this.address,
    required this.averagePrice,
    required this.rating,
    required this.coordinates,
    this.cuisineTypes = const [],
    this.openingHours = const {},
    required this.contactInfo,
    this.websiteUrl,
    this.hasDelivery = false,
    this.hasTakeaway = false,
    this.hasReservations = false,
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
        averagePrice,
        rating,
        coordinates,
        cuisineTypes,
        openingHours,
        contactInfo,
        websiteUrl,
        hasDelivery,
        hasTakeaway,
        hasReservations,
      ];
}
