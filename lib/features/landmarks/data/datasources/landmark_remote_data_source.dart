import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../models/landmark_model.dart';

/// Abstract class for the landmark remote data source
abstract class LandmarkRemoteDataSource {
  /// Get all landmarks from the remote API
  Future<List<LandmarkModel>> getLandmarks();

  /// Get a landmark by its ID from the remote API
  Future<LandmarkModel> getLandmarkById(String id);

  /// Get landmarks by city from the remote API
  Future<List<LandmarkModel>> getLandmarksByCity(String city);

  /// Get landmarks by tags from the remote API
  Future<List<LandmarkModel>> getLandmarksByTags(List<String> tags);

  /// Search landmarks by query from the remote API
  Future<List<LandmarkModel>> searchLandmarks(String query);
}

/// Implementation of the landmark remote data source
class LandmarkRemoteDataSourceImpl implements LandmarkRemoteDataSource {
  /// Http client
  final http.Client client;

  /// Base API URL
  final String baseUrl;

  /// Creates a new [LandmarkRemoteDataSourceImpl] instance
  LandmarkRemoteDataSourceImpl({
    required this.client,
    this.baseUrl = 'https://api.example.com',
  });

  @override
  Future<List<LandmarkModel>> getLandmarks() async {
    final response = await client.get(
      Uri.parse('$baseUrl/landmarks'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> landmarksJson = json.decode(response.body);
      return landmarksJson.map((json) => LandmarkModel.fromJson(json)).toList();
    } else {
      throw ServerException(message: 'Failed to fetch landmarks');
    }
  }

  @override
  Future<LandmarkModel> getLandmarkById(String id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/landmarks/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return LandmarkModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(message: 'Failed to fetch landmark with ID: $id');
    }
  }

  @override
  Future<List<LandmarkModel>> getLandmarksByCity(String city) async {
    final response = await client.get(
      Uri.parse('$baseUrl/landmarks/city/$city'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> landmarksJson = json.decode(response.body);
      return landmarksJson.map((json) => LandmarkModel.fromJson(json)).toList();
    } else {
      throw ServerException(
          message: 'Failed to fetch landmarks for city: $city');
    }
  }

  @override
  Future<List<LandmarkModel>> getLandmarksByTags(List<String> tags) async {
    final queryParams = tags.map((tag) => 'tags=$tag').join('&');
    final response = await client.get(
      Uri.parse('$baseUrl/landmarks/tags?$queryParams'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> landmarksJson = json.decode(response.body);
      return landmarksJson.map((json) => LandmarkModel.fromJson(json)).toList();
    } else {
      throw ServerException(message: 'Failed to fetch landmarks by tags');
    }
  }

  @override
  Future<List<LandmarkModel>> searchLandmarks(String query) async {
    final response = await client.get(
      Uri.parse('$baseUrl/landmarks/search?q=$query'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> landmarksJson = json.decode(response.body);
      return landmarksJson.map((json) => LandmarkModel.fromJson(json)).toList();
    } else {
      throw ServerException(
          message: 'Failed to search landmarks with query: $query');
    }
  }
}
