import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/restaurant_model.dart';

/// Abstract class for the restaurant local data source
abstract class RestaurantLocalDataSource {
  /// Get cached restaurants
  Future<List<RestaurantModel>> getCachedRestaurants();

  /// Cache restaurants
  Future<void> cacheRestaurants(List<RestaurantModel> restaurantsToCache);

  /// Get cached restaurant by ID
  Future<RestaurantModel> getCachedRestaurantById(String id);

  /// Cache a single restaurant
  Future<void> cacheRestaurant(RestaurantModel restaurantToCache);

  /// Get restaurants by city from cache
  Future<List<RestaurantModel>> getCachedRestaurantsByCity(String city);

  /// Get restaurants by cuisine type from cache
  Future<List<RestaurantModel>> getCachedRestaurantsByCuisine(
      String cuisineType);

  /// Get restaurants by price range from cache
  Future<List<RestaurantModel>> getCachedRestaurantsByPriceRange(
      double minPrice, double maxPrice);
}

/// Implementation of the restaurant local data source
class RestaurantLocalDataSourceImpl implements RestaurantLocalDataSource {
  /// Shared preferences instance
  final SharedPreferences sharedPreferences;

  /// Key for cached restaurants
  static const String cachedRestaurantsKey = 'CACHED_RESTAURANTS';

  /// Key prefix for cached restaurant
  static const String cachedRestaurantKeyPrefix = 'CACHED_RESTAURANT_';

  /// Creates a new [RestaurantLocalDataSourceImpl] instance
  RestaurantLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<RestaurantModel>> getCachedRestaurants() async {
    final jsonString = sharedPreferences.getString(cachedRestaurantsKey);
    if (jsonString != null) {
      final List<dynamic> decodedJson = json.decode(jsonString);
      return decodedJson.map((json) => RestaurantModel.fromJson(json)).toList();
    } else {
      throw CacheException(message: 'No cached restaurants found');
    }
  }

  @override
  Future<void> cacheRestaurants(
      List<RestaurantModel> restaurantsToCache) async {
    final List<Map<String, dynamic>> jsonList =
        restaurantsToCache.map((restaurant) => restaurant.toJson()).toList();
    await sharedPreferences.setString(
      cachedRestaurantsKey,
      json.encode(jsonList),
    );
  }

  @override
  Future<RestaurantModel> getCachedRestaurantById(String id) async {
    final jsonString =
        sharedPreferences.getString('$cachedRestaurantKeyPrefix$id');
    if (jsonString != null) {
      return RestaurantModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheException(message: 'No cached restaurant found with ID: $id');
    }
  }

  @override
  Future<void> cacheRestaurant(RestaurantModel restaurantToCache) async {
    await sharedPreferences.setString(
      '$cachedRestaurantKeyPrefix${restaurantToCache.id}',
      json.encode(restaurantToCache.toJson()),
    );
  }

  @override
  Future<List<RestaurantModel>> getCachedRestaurantsByCity(String city) async {
    try {
      final restaurants = await getCachedRestaurants();
      return restaurants
          .where((restaurant) =>
              restaurant.location.toLowerCase() == city.toLowerCase())
          .toList();
    } on CacheException {
      throw CacheException(
          message: 'No cached restaurants found for city: $city');
    }
  }

  @override
  Future<List<RestaurantModel>> getCachedRestaurantsByCuisine(
      String cuisineType) async {
    try {
      final restaurants = await getCachedRestaurants();
      return restaurants
          .where((restaurant) => restaurant.cuisineTypes.any(
              (cuisine) => cuisine.toLowerCase() == cuisineType.toLowerCase()))
          .toList();
    } on CacheException {
      throw CacheException(
          message: 'No cached restaurants found with cuisine: $cuisineType');
    }
  }

  @override
  Future<List<RestaurantModel>> getCachedRestaurantsByPriceRange(
      double minPrice, double maxPrice) async {
    try {
      final restaurants = await getCachedRestaurants();
      return restaurants
          .where((restaurant) =>
              restaurant.averagePrice >= minPrice &&
              restaurant.averagePrice <= maxPrice)
          .toList();
    } on CacheException {
      throw CacheException(
          message:
              'No cached restaurants found in price range: $minPrice - $maxPrice');
    }
  }
}
