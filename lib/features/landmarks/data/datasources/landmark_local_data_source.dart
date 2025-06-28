import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/landmark_model.dart';

/// Abstract class for the landmark local data source
abstract class LandmarkLocalDataSource {
  /// Get cached landmarks
  Future<List<LandmarkModel>> getCachedLandmarks();

  /// Cache landmarks
  Future<void> cacheLandmarks(List<LandmarkModel> landmarksToCache);

  /// Get cached landmark by ID
  Future<LandmarkModel> getCachedLandmarkById(String id);

  /// Cache a single landmark
  Future<void> cacheLandmark(LandmarkModel landmarkToCache);
}

/// Implementation of the landmark local data source
class LandmarkLocalDataSourceImpl implements LandmarkLocalDataSource {
  /// Shared preferences instance
  final SharedPreferences sharedPreferences;

  /// Key for cached landmarks
  static const String cachedLandmarksKey = 'CACHED_LANDMARKS';

  /// Key prefix for cached landmark
  static const String cachedLandmarkKeyPrefix = 'CACHED_LANDMARK_';

  /// Creates a new [LandmarkLocalDataSourceImpl] instance
  LandmarkLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<LandmarkModel>> getCachedLandmarks() async {
    final jsonString = sharedPreferences.getString(cachedLandmarksKey);
    if (jsonString != null) {
      final List<dynamic> decodedJson = json.decode(jsonString);
      return decodedJson.map((json) => LandmarkModel.fromJson(json)).toList();
    } else {
      throw CacheException(message: 'No cached landmarks found');
    }
  }

  @override
  Future<void> cacheLandmarks(List<LandmarkModel> landmarksToCache) async {
    final List<Map<String, dynamic>> jsonList =
        landmarksToCache.map((landmark) => landmark.toJson()).toList();
    await sharedPreferences.setString(
      cachedLandmarksKey,
      json.encode(jsonList),
    );
  }

  @override
  Future<LandmarkModel> getCachedLandmarkById(String id) async {
    final jsonString =
        sharedPreferences.getString('$cachedLandmarkKeyPrefix$id');
    if (jsonString != null) {
      return LandmarkModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheException(message: 'No cached landmark found with ID: $id');
    }
  }

  @override
  Future<void> cacheLandmark(LandmarkModel landmarkToCache) async {
    await sharedPreferences.setString(
      '$cachedLandmarkKeyPrefix${landmarkToCache.id}',
      json.encode(landmarkToCache.toJson()),
    );
  }
}
