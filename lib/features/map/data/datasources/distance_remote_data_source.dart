import 'package:open_route_service/open_route_service.dart';
import 'package:latlong2/latlong.dart';

/// Interface for the distance remote data source
abstract class DistanceRemoteDataSource {
  /// Calculate distance between two locations
  Future<double> calculateDistance(LatLng origin, LatLng destination);

  /// Get route between two locations
  Future<List<LatLng>> getRoute(LatLng origin, LatLng destination);
}

/// Implementation of the distance remote data source
class DistanceRemoteDataSourceImpl implements DistanceRemoteDataSource {
  /// Open Route Service client
  final OpenRouteService _ors;

  /// Google Maps API key
  final String apiKey;

  /// Creates a new [DistanceRemoteDataSourceImpl] instance
  DistanceRemoteDataSourceImpl({
    required this.apiKey,
  }) : _ors = OpenRouteService(apiKey: apiKey);

  @override
  Future<double> calculateDistance(LatLng origin, LatLng destination) async {
    final route = await _ors.directionsRouteCoordsGet(
      startCoordinate:
          ORSCoordinate(latitude: origin.latitude, longitude: origin.longitude),
      endCoordinate: ORSCoordinate(
          latitude: destination.latitude, longitude: destination.longitude),
      profileOverride: ORSProfile.drivingCar,
    );
    // Calculate total distance in km
    double totalDistance = 0.0;
    for (int i = 1; i < route.length; i++) {
      totalDistance += Distance().as(
        LengthUnit.Kilometer,
        LatLng(route[i - 1].latitude, route[i - 1].longitude),
        LatLng(route[i].latitude, route[i].longitude),
      );
    }
    return totalDistance;
  }

  @override
  Future<List<LatLng>> getRoute(LatLng origin, LatLng destination) async {
    final route = await _ors.directionsRouteCoordsGet(
      startCoordinate:
          ORSCoordinate(latitude: origin.latitude, longitude: origin.longitude),
      endCoordinate: ORSCoordinate(
          latitude: destination.latitude, longitude: destination.longitude),
      profileOverride: ORSProfile.drivingCar,
    );
    return route.map((c) => LatLng(c.latitude, c.longitude)).toList();
  }
}
