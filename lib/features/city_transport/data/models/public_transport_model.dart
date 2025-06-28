import '../../domain/entities/public_transport.dart';

class PublicTransportModel extends PublicTransport {
  const PublicTransportModel({
    required String id,
    required String city,
    required String type,
    required String name,
    required String schedule,
    required double price,
    required String description,
  }) : super(
          id: id,
          city: city,
          type: type,
          name: name,
          schedule: schedule,
          price: price,
          description: description,
        );

  factory PublicTransportModel.fromJson(Map<String, dynamic> json) {
    return PublicTransportModel(
      id: json['id'],
      city: json['city'],
      type: json['type'],
      name: json['name'],
      schedule: json['schedule'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city': city,
      'type': type,
      'name': name,
      'schedule': schedule,
      'price': price,
      'description': description,
    };
  }
}
