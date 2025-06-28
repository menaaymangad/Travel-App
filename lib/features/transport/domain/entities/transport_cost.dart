import 'package:equatable/equatable.dart';

/// Enum representing different transport types
enum TransportType {
  /// Car transport
  car,

  /// Bus transport
  bus,

  /// Train transport
  train,

  /// Plane transport
  plane,

  /// Boat transport
  boat,

  /// Walking
  walking
}

/// Entity representing transport cost information
class TransportCost extends Equatable {
  /// Origin location name
  final String origin;

  /// Destination location name
  final String destination;

  /// Distance in kilometers
  final double distanceInKm;

  /// Type of transport
  final TransportType transportType;

  /// Cost in Egyptian pounds
  final double costInEGP;

  /// Estimated travel time in minutes
  final int durationInMinutes;

  /// Creates a new [TransportCost] instance
  const TransportCost({
    required this.origin,
    required this.destination,
    required this.distanceInKm,
    required this.transportType,
    required this.costInEGP,
    required this.durationInMinutes,
  });

  @override
  List<Object?> get props => [
        origin,
        destination,
        distanceInKm,
        transportType,
        costInEGP,
        durationInMinutes,
      ];

  /// Get the transport type as a readable string
  String get transportTypeString {
    switch (transportType) {
      case TransportType.car:
        return 'Car';
      case TransportType.bus:
        return 'Bus';
      case TransportType.train:
        return 'Train';
      case TransportType.plane:
        return 'Plane';
      case TransportType.boat:
        return 'Boat';
      case TransportType.walking:
        return 'Walking';
    }
  }

  /// Get the formatted cost string
  String get costString => '${costInEGP.toStringAsFixed(2)} EGP';

  /// Get the formatted duration string
  String get durationString {
    if (durationInMinutes < 60) {
      return '$durationInMinutes min';
    } else {
      final hours = durationInMinutes ~/ 60;
      final minutes = durationInMinutes % 60;
      return '$hours h ${minutes > 0 ? '$minutes min' : ''}';
    }
  }
}
