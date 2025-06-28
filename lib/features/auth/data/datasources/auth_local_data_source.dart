import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/util/constants.dart';
import '../models/user_model.dart';

/// Interface for local authentication data source
abstract class AuthLocalDataSource {
  /// Caches the user data
  Future<void> cacheUser(UserModel userModel);

  /// Gets the cached user data
  Future<UserModel> getCachedUser();

  /// Checks if a user is cached
  Future<bool> isUserCached();

  /// Clears the cached user data
  Future<void> clearCachedUser();
}

/// Implementation of [AuthLocalDataSource] using SharedPreferences
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _sharedPreferences;

  /// Creates a new [AuthLocalDataSourceImpl] instance
  AuthLocalDataSourceImpl({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  @override
  Future<void> cacheUser(UserModel userModel) async {
    try {
      await _sharedPreferences.setString(
        AppConstants.cachedUserIdKey,
        userModel.uid,
      );
      
      await _sharedPreferences.setString(
        AppConstants.cachedUserDataKey,
        json.encode(userModel.toJson()),
      );
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<UserModel> getCachedUser() async {
    try {
      final jsonString = _sharedPreferences.getString(AppConstants.cachedUserDataKey);
      
      if (jsonString == null) {
        throw CacheException(message: 'No cached user found');
      }
      
      return UserModel.fromJson(json.decode(jsonString));
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> isUserCached() async {
    try {
      return _sharedPreferences.containsKey(AppConstants.cachedUserIdKey);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> clearCachedUser() async {
    try {
      await _sharedPreferences.remove(AppConstants.cachedUserIdKey);
      await _sharedPreferences.remove(AppConstants.cachedUserDataKey);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
} 