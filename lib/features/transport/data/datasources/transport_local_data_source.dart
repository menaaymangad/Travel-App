import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/transport_cost.dart';
import '../models/transport_cost_model.dart';

/// Interface for the transport local data source
abstract class TransportLocalDataSource {
  /// Get cached transport costs
  Future<List<TransportCostModel>> getCachedTransportCosts(
    String origin,
    String destination,
  );

  /// Cache transport costs
  Future<void> cacheTransportCosts(
    String origin,
    String destination,
    List<TransportCostModel> transportCosts,
  );

  /// Get cached transport cost by type
  Future<TransportCostModel> getCachedTransportCostByType(
    String origin,
    String destination,
    TransportType transportType,
  );

  /// Cache transport cost by type
  Future<void> cacheTransportCostByType(
    String origin,
    String destination,
    TransportType transportType,
    TransportCostModel transportCost,
  );
}

/// Implementation of the transport local data source
class TransportLocalDataSourceImpl implements TransportLocalDataSource {
  /// Shared preferences instance for caching
  final SharedPreferences sharedPreferences;

  /// Creates a new [TransportLocalDataSourceImpl] instance
  TransportLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TransportCostModel>> getCachedTransportCosts(
    String origin,
    String destination,
  ) async {
    final key = _generateCacheKey(origin, destination);
    final jsonString = sharedPreferences.getString(key);

    if (jsonString != null) {
      final jsonList = json.decode(jsonString) as List<dynamic>;
      return jsonList
          .map((jsonMap) => TransportCostModel.fromJson(jsonMap))
          .toList();
    } else {
      throw CacheException(message: 'Cache exception');
    }
  }

  @override
  Future<void> cacheTransportCosts(
    String origin,
    String destination,
    List<TransportCostModel> transportCosts,
  ) async {
    final key = _generateCacheKey(origin, destination);
    final jsonList = transportCosts.map((cost) => cost.toJson()).toList();
    await sharedPreferences.setString(key, json.encode(jsonList));
  }

  @override
  Future<TransportCostModel> getCachedTransportCostByType(
    String origin,
    String destination,
    TransportType transportType,
  ) async {
    final key = _generateCacheKeyWithType(origin, destination, transportType);
    final jsonString = sharedPreferences.getString(key);

    if (jsonString != null) {
      final jsonMap = json.decode(jsonString);
      return TransportCostModel.fromJson(jsonMap);
    } else {
      throw CacheException(message: 'Cache exception');
    }
  }

  @override
  Future<void> cacheTransportCostByType(
    String origin,
    String destination,
    TransportType transportType,
    TransportCostModel transportCost,
  ) async {
    final key = _generateCacheKeyWithType(origin, destination, transportType);
    await sharedPreferences.setString(key, json.encode(transportCost.toJson()));
  }

  /// Generate a cache key for transport costs
  String _generateCacheKey(String origin, String destination) {
    return 'TRANSPORT_COSTS_${origin.toLowerCase()}_${destination.toLowerCase()}';
  }

  /// Generate a cache key for transport cost by type
  String _generateCacheKeyWithType(
    String origin,
    String destination,
    TransportType transportType,
  ) {
    final typeString = transportType.toString().split('.').last;
    return 'TRANSPORT_COST_${origin.toLowerCase()}_${destination.toLowerCase()}_$typeString';
  }
}
