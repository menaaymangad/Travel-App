import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../models/hotel_model.dart';

/// Abstract class for the hotel remote data source
abstract class HotelRemoteDataSource {
  /// Get all hotels from the remote API
  Future<List<HotelModel>> getHotels();

  /// Get a hotel by its ID from the remote API
  Future<HotelModel> getHotelById(String id);

  /// Get hotels by city from the remote API
  Future<List<HotelModel>> getHotelsByCity(String city);

  /// Get hotels by star rating from the remote API
  Future<List<HotelModel>> getHotelsByStars(int stars);

  /// Get hotels by price range from the remote API
  Future<List<HotelModel>> getHotelsByPriceRange(
      double minPrice, double maxPrice);

  /// Search hotels by query from the remote API
  Future<List<HotelModel>> searchHotels(String query);
}

/// Implementation of the hotel remote data source
class HotelRemoteDataSourceImpl implements HotelRemoteDataSource {
  /// Http client
  final http.Client client;

  /// Base API URL
  final String baseUrl;

  /// Creates a new [HotelRemoteDataSourceImpl] instance
  HotelRemoteDataSourceImpl({
    required this.client,
    this.baseUrl = 'https://api.example.com',
  });

  @override
  Future<List<HotelModel>> getHotels() async {
    final response = await client.get(
      Uri.parse('$baseUrl/hotels'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> hotelsJson = json.decode(response.body);
      return hotelsJson.map((json) => HotelModel.fromJson(json)).toList();
    } else {
      throw ServerException(message: 'Failed to fetch hotels');
    }
  }

  @override
  Future<HotelModel> getHotelById(String id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/hotels/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return HotelModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(message: 'Failed to fetch hotel with ID: $id');
    }
  }

  @override
  Future<List<HotelModel>> getHotelsByCity(String city) async {
    final response = await client.get(
      Uri.parse('$baseUrl/hotels/city/$city'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> hotelsJson = json.decode(response.body);
      return hotelsJson.map((json) => HotelModel.fromJson(json)).toList();
    } else {
      throw ServerException(message: 'Failed to fetch hotels for city: $city');
    }
  }

  @override
  Future<List<HotelModel>> getHotelsByStars(int stars) async {
    final response = await client.get(
      Uri.parse('$baseUrl/hotels/stars/$stars'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> hotelsJson = json.decode(response.body);
      return hotelsJson.map((json) => HotelModel.fromJson(json)).toList();
    } else {
      throw ServerException(
          message: 'Failed to fetch hotels with $stars stars');
    }
  }

  @override
  Future<List<HotelModel>> getHotelsByPriceRange(
      double minPrice, double maxPrice) async {
    final response = await client.get(
      Uri.parse('$baseUrl/hotels/price-range?min=$minPrice&max=$maxPrice'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> hotelsJson = json.decode(response.body);
      return hotelsJson.map((json) => HotelModel.fromJson(json)).toList();
    } else {
      throw ServerException(
          message:
              'Failed to fetch hotels in price range: $minPrice - $maxPrice');
    }
  }

  @override
  Future<List<HotelModel>> searchHotels(String query) async {
    final response = await client.get(
      Uri.parse('$baseUrl/hotels/search?q=$query'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> hotelsJson = json.decode(response.body);
      return hotelsJson.map((json) => HotelModel.fromJson(json)).toList();
    } else {
      throw ServerException(
          message: 'Failed to search hotels with query: $query');
    }
  }
}
