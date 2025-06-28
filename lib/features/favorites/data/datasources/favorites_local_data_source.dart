import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/favorite_model.dart';

abstract class FavoritesLocalDataSource {
  Future<List<FavoriteModel>> getFavorites();
  Future<void> addFavorite(FavoriteModel favorite);
  Future<void> removeFavorite(String id);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  static const String favoritesKey = 'favorites';
  final SharedPreferences sharedPreferences;

  FavoritesLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    final jsonString = sharedPreferences.getString(favoritesKey);
    if (jsonString == null) return [];
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => FavoriteModel.fromJson(e)).toList();
  }

  @override
  Future<void> addFavorite(FavoriteModel favorite) async {
    final favorites = await getFavorites();
    favorites.add(favorite);
    final jsonString = json.encode(favorites.map((e) => e.toJson()).toList());
    await sharedPreferences.setString(favoritesKey, jsonString);
  }

  @override
  Future<void> removeFavorite(String id) async {
    final favorites = await getFavorites();
    favorites.removeWhere((fav) => fav.id == id);
    final jsonString = json.encode(favorites.map((e) => e.toJson()).toList());
    await sharedPreferences.setString(favoritesKey, jsonString);
  }
}
