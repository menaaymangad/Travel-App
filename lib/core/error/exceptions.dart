/// Exception thrown when there is a server error
class ServerException implements Exception {
  final String message;

  ServerException({required this.message});
}

/// Exception thrown when there is a cache error
class CacheException implements Exception {
  final String message;

  CacheException({required this.message});
}

/// Exception thrown when there is a network error
class NetworkException implements Exception {
  final String message;

  NetworkException({required this.message});
}

/// Exception thrown when there is an authentication error
class AuthException implements Exception {
  final String message;

  AuthException({required this.message});
} 