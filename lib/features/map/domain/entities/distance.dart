import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

/// Entity representing a distance between two locations
class Distance extends Equatable {
  /// Starting location
  final LatLng origin;

  /// Destination location
  final LatLng destination;

  /// Distance in meters
  final double distanceInMeters;

  /// Distance in kilometers (formatted)
  final String distanceText;

  /// Estimated travel time in seconds
  final int durationInSeconds;

  /// Estimated travel time (formatted)
  final String durationText;

  /// Polyline points for drawing the route
  final List<LatLng> polylinePoints;

  /// Creates a new [Distance] instance
  const Distance({
    required this.origin,
    required this.destination,
    required this.distanceInMeters,
    required this.distanceText,
    required this.durationInSeconds,
    required this.durationText,
    required this.polylinePoints,
  });

  @override
  List<Object?> get props => [
        origin,
        destination,
        distanceInMeters,
        distanceText,
        durationInSeconds,
        durationText,
        polylinePoints,
      ];
}
