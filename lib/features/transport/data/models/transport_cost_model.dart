import '../../domain/entities/transport_cost.dart';

/// Model class for transport cost information
class TransportCostModel extends TransportCost {
  /// Creates a new [TransportCostModel] instance
  const TransportCostModel({
    required String origin,
    required String destination,
    required double distanceInKm,
    required TransportType transportType,
    required double costInEGP,
    required int durationInMinutes,
  }) : super(
          origin: origin,
          destination: destination,
          distanceInKm: distanceInKm,
          transportType: transportType,
          costInEGP: costInEGP,
          durationInMinutes: durationInMinutes,
        );

  /// Create a [TransportCostModel] from a JSON map
  factory TransportCostModel.fromJson(Map<String, dynamic> json) {
    return TransportCostModel(
      origin: json['origin'],
      destination: json['destination'],
      distanceInKm: json['distance_km'].toDouble(),
      transportType: _parseTransportType(json['transport_type']),
      costInEGP: json['cost_egp'].toDouble(),
      durationInMinutes: json['duration_minutes'],
    );
  }

  /// Convert the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'origin': origin,
      'destination': destination,
      'distance_km': distanceInKm,
      'transport_type': _transportTypeToString(transportType),
      'cost_egp': costInEGP,
      'duration_minutes': durationInMinutes,
    };
  }

  /// Parse transport type from string
  static TransportType _parseTransportType(String type) {
    switch (type.toLowerCase()) {
      case 'car':
        return TransportType.car;
      case 'bus':
        return TransportType.bus;
      case 'train':
        return TransportType.train;
      case 'plane':
        return TransportType.plane;
      case 'boat':
        return TransportType.boat;
      case 'walking':
        return TransportType.walking;
      default:
        return TransportType.car;
    }
  }

  /// Convert transport type to string
  static String _transportTypeToString(TransportType type) {
    switch (type) {
      case TransportType.car:
        return 'car';
      case TransportType.bus:
        return 'bus';
      case TransportType.train:
        return 'train';
      case TransportType.plane:
        return 'plane';
      case TransportType.boat:
        return 'boat';
      case TransportType.walking:
        return 'walking';
    }
  }
}
