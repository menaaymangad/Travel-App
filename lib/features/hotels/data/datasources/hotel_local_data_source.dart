import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/hotel_model.dart';

/// Abstract class for the hotel local data source
abstract class HotelLocalDataSource {
  /// Get cached hotels
  Future<List<HotelModel>> getCachedHotels();

  /// Cache hotels
  Future<void> cacheHotels(List<HotelModel> hotelsToCache);

  /// Get cached hotel by ID
  Future<HotelModel> getCachedHotelById(String id);

  /// Cache a single hotel
  Future<void> cacheHotel(HotelModel hotelToCache);

  /// Get hotels by city from cache
  Future<List<HotelModel>> getCachedHotelsByCity(String city);

  /// Get hotels by star rating from cache
  Future<List<HotelModel>> getCachedHotelsByStars(int stars);

  /// Get hotels by price range from cache
  Future<List<HotelModel>> getCachedHotelsByPriceRange(
      double minPrice, double maxPrice);
}

/// Implementation of the hotel local data source
class HotelLocalDataSourceImpl implements HotelLocalDataSource {
  /// Shared preferences instance
  final SharedPreferences sharedPreferences;

  /// Key for cached hotels
  static const String cachedHotelsKey = 'CACHED_HOTELS';

  /// Key prefix for cached hotel
  static const String cachedHotelKeyPrefix = 'CACHED_HOTEL_';

  /// Creates a new [HotelLocalDataSourceImpl] instance
  HotelLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<HotelModel>> getCachedHotels() async {
    final jsonString = sharedPreferences.getString(cachedHotelsKey);
    if (jsonString != null) {
      final List<dynamic> decodedJson = json.decode(jsonString);
      return decodedJson.map((json) => HotelModel.fromJson(json)).toList();
    } else {
      throw CacheException(message: 'No cached hotels found');
    }
  }

  @override
  Future<void> cacheHotels(List<HotelModel> hotelsToCache) async {
    final List<Map<String, dynamic>> jsonList =
        hotelsToCache.map((hotel) => hotel.toJson()).toList();
    await sharedPreferences.setString(
      cachedHotelsKey,
      json.encode(jsonList),
    );
  }

  @override
  Future<HotelModel> getCachedHotelById(String id) async {
    final jsonString = sharedPreferences.getString('$cachedHotelKeyPrefix$id');
    if (jsonString != null) {
      return HotelModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheException(message: 'No cached hotel found with ID: $id');
    }
  }

  @override
  Future<void> cacheHotel(HotelModel hotelToCache) async {
    await sharedPreferences.setString(
      '$cachedHotelKeyPrefix${hotelToCache.id}',
      json.encode(hotelToCache.toJson()),
    );
  }

  @override
  Future<List<HotelModel>> getCachedHotelsByCity(String city) async {
    try {
      final hotels = await getCachedHotels();
      return hotels
          .where((hotel) => hotel.location.toLowerCase() == city.toLowerCase())
          .toList();
    } on CacheException {
      throw CacheException(message: 'No cached hotels found for city: $city');
    }
  }

  @override
  Future<List<HotelModel>> getCachedHotelsByStars(int stars) async {
    try {
      final hotels = await getCachedHotels();
      return hotels.where((hotel) => hotel.stars == stars).toList();
    } on CacheException {
      throw CacheException(message: 'No cached hotels found with $stars stars');
    }
  }

  @override
  Future<List<HotelModel>> getCachedHotelsByPriceRange(
      double minPrice, double maxPrice) async {
    try {
      final hotels = await getCachedHotels();
      return hotels
          .where((hotel) =>
              hotel.pricePerNight >= minPrice &&
              hotel.pricePerNight <= maxPrice)
          .toList();
    } on CacheException {
      throw CacheException(
          message:
              'No cached hotels found in price range: $minPrice - $maxPrice');
    }
  }
}
