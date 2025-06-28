import 'package:latlong2/latlong.dart';
import 'package:travelapp/features/map/domain/entities/distance.dart'
    as entities;

/// Model class for distance information
class DistanceModel extends entities.Distance {
  /// Creates a new [DistanceModel] instance
  const DistanceModel({
    required LatLng origin,
    required LatLng destination,
    required double distanceInMeters,
    required String distanceText,
    required int durationInSeconds,
    required String durationText,
    required List<LatLng> polylinePoints,
  }) : super(
          origin: origin,
          destination: destination,
          distanceInMeters: distanceInMeters,
          distanceText: distanceText,
          durationInSeconds: durationInSeconds,
          durationText: durationText,
          polylinePoints: polylinePoints,
        );

  /// Create a [DistanceModel] from a JSON map
  factory DistanceModel.fromJson(Map<String, dynamic> json) {
    // Parse the routes data from Google Maps Directions API
    final routes = json['routes'] as List;
    if (routes.isEmpty) {
      throw Exception('No routes found');
    }

    final route = routes[0];
    final leg = route['legs'][0];

    // Extract distance and duration information
    final distance = leg['distance'];
    final duration = leg['duration'];

    // Extract polyline points
    final polylinePoints =
        _decodePolyline(route['overview_polyline']['points']);

    // Extract start and end locations
    final startLocation = leg['start_location'];
    final endLocation = leg['end_location'];

    return DistanceModel(
      origin: LatLng(startLocation['lat'], startLocation['lng']),
      destination: LatLng(endLocation['lat'], endLocation['lng']),
      distanceInMeters: distance['value'].toDouble(),
      distanceText: distance['text'],
      durationInSeconds: duration['value'],
      durationText: duration['text'],
      polylinePoints: polylinePoints,
    );
  }

  /// Convert the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'origin': {
        'lat': origin.latitude,
        'lng': origin.longitude,
      },
      'destination': {
        'lat': destination.latitude,
        'lng': destination.longitude,
      },
      'distance': {
        'value': distanceInMeters,
        'text': distanceText,
      },
      'duration': {
        'value': durationInSeconds,
        'text': durationText,
      },
      'polyline_points': _encodePolyline(polylinePoints),
    };
  }

  /// Decode a polyline string into a list of LatLng points
  static List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      final position = LatLng(lat / 1E5, lng / 1E5);
      poly.add(position);
    }
    return poly;
  }

  /// Encode a list of LatLng points into a polyline string
  static String _encodePolyline(List<LatLng> points) {
    String encodedString = "";
    var previousLat = 0;
    var previousLng = 0;

    for (var point in points) {
      var lat = (point.latitude * 1E5).round();
      var lng = (point.longitude * 1E5).round();

      encodedString += _encodePoint(lat - previousLat);
      encodedString += _encodePoint(lng - previousLng);

      previousLat = lat;
      previousLng = lng;
    }
    return encodedString;
  }

  /// Helper method to encode a single point in the polyline
  static String _encodePoint(int point) {
    point = (point < 0) ? ~(point << 1) : (point << 1);
    String encodedString = "";

    while (point >= 0x20) {
      encodedString += String.fromCharCode((0x20 | (point & 0x1f)) + 63);
      point >>= 5;
    }

    encodedString += String.fromCharCode(point + 63);
    return encodedString;
  }
}
