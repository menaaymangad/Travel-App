import '../models/public_transport_model.dart';

abstract class PublicTransportRemoteDataSource {
  Future<List<PublicTransportModel>> getPublicTransportInfo({String? city});
}

class PublicTransportRemoteDataSourceImpl
    implements PublicTransportRemoteDataSource {
  @override
  Future<List<PublicTransportModel>> getPublicTransportInfo(
      {String? city}) async {
    // In a real app, fetch from Firebase or API
    await Future.delayed(const Duration(milliseconds: 500));
    final all = [
      PublicTransportModel(
        id: '1',
        city: 'Cairo',
        type: 'Metro',
        name: 'Cairo Metro Line 1',
        schedule: '05:00 - 00:30',
        price: 5.0,
        description: 'Main metro line in Cairo.',
      ),
      PublicTransportModel(
        id: '2',
        city: 'Cairo',
        type: 'Bus',
        name: 'Cairo Bus 357',
        schedule: '06:00 - 23:00',
        price: 3.0,
        description: 'Connects downtown to Giza.',
      ),
      PublicTransportModel(
        id: '3',
        city: 'Alexandria',
        type: 'Tram',
        name: 'Alexandria Tram',
        schedule: '06:00 - 22:00',
        price: 2.0,
        description: 'Historic tram system in Alexandria.',
      ),
    ];
    if (city != null) {
      return all.where((t) => t.city == city).toList();
    }
    return all;
  }
}
