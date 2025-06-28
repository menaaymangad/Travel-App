import 'package:equatable/equatable.dart';

class PublicTransport extends Equatable {
  final String id;
  final String city;
  final String type; // e.g., Bus, Metro, Tram
  final String name;
  final String schedule;
  final double price;
  final String description;

  const PublicTransport({
    required this.id,
    required this.city,
    required this.type,
    required this.name,
    required this.schedule,
    required this.price,
    required this.description,
  });

  @override
  List<Object?> get props =>
      [id, city, type, name, schedule, price, description];
}
