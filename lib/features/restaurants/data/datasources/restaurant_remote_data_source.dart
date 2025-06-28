import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../models/restaurant_model.dart';

/// Abstract class for the restaurant remote data source
abstract class RestaurantRemoteDataSource {
  /// Get all restaurants from the remote API
  Future<List<RestaurantModel>> getRestaurants();

  /// Get a restaurant by its ID from the remote API
  Future<RestaurantModel> getRestaurantById(String id);

  /// Get restaurants by city from the remote API
  Future<List<RestaurantModel>> getRestaurantsByCity(String city);

  /// Get restaurants by cuisine type from the remote API
  Future<List<RestaurantModel>> getRestaurantsByCuisine(String cuisineType);

  /// Get restaurants by price range from the remote API
  Future<List<RestaurantModel>> getRestaurantsByPriceRange(
      double minPrice, double maxPrice);

  /// Search restaurants by query from the remote API
  Future<List<RestaurantModel>> searchRestaurants(String query);
}

/// Implementation of the restaurant remote data source
class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  /// Http client
  final http.Client client;

  /// Base API URL
  final String baseUrl;

  /// Creates a new [RestaurantRemoteDataSourceImpl] instance
  RestaurantRemoteDataSourceImpl({
    required this.client,
    this.baseUrl = 'https://api.example.com',
  });

  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    final response = await client.get(
      Uri.parse('$baseUrl/restaurants'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> restaurantsJson = json.decode(response.body);
      return restaurantsJson
          .map((json) => RestaurantModel.fromJson(json))
          .toList();
    } else {
      throw ServerException(message: 'Failed to fetch restaurants');
    }
  }

  @override
  Future<RestaurantModel> getRestaurantById(String id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/restaurants/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return RestaurantModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(message: 'Failed to fetch restaurant with ID: $id');
    }
  }

  @override
  Future<List<RestaurantModel>> getRestaurantsByCity(String city) async {
    final response = await client.get(
      Uri.parse('$baseUrl/restaurants/city/$city'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> restaurantsJson = json.decode(response.body);
      return restaurantsJson
          .map((json) => RestaurantModel.fromJson(json))
          .toList();
    } else {
      throw ServerException(
          message: 'Failed to fetch restaurants for city: $city');
    }
  }

  @override
  Future<List<RestaurantModel>> getRestaurantsByCuisine(
      String cuisineType) async {
    final response = await client.get(
      Uri.parse('$baseUrl/restaurants/cuisine/$cuisineType'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> restaurantsJson = json.decode(response.body);
      return restaurantsJson
          .map((json) => RestaurantModel.fromJson(json))
          .toList();
    } else {
      throw ServerException(
          message: 'Failed to fetch restaurants with cuisine: $cuisineType');
    }
  }

  @override
  Future<List<RestaurantModel>> getRestaurantsByPriceRange(
      double minPrice, double maxPrice) async {
    final response = await client.get(
      Uri.parse('$baseUrl/restaurants/price-range?min=$minPrice&max=$maxPrice'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> restaurantsJson = json.decode(response.body);
      return restaurantsJson
          .map((json) => RestaurantModel.fromJson(json))
          .toList();
    } else {
      throw ServerException(
          message:
              'Failed to fetch restaurants in price range: $minPrice - $maxPrice');
    }
  }

  @override
  Future<List<RestaurantModel>> searchRestaurants(String query) async {
    final response = await client.get(
      Uri.parse('$baseUrl/restaurants/search?q=$query'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> restaurantsJson = json.decode(response.body);
      return restaurantsJson
          .map((json) => RestaurantModel.fromJson(json))
          .toList();
    } else {
      throw ServerException(
          message: 'Failed to search restaurants with query: $query');
    }
  }
}
