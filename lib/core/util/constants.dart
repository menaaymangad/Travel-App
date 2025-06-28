/// Constants used throughout the app
class AppConstants {
  /// Cache key for storing the user ID
  static const String cachedUserIdKey = 'CACHED_USER_ID';
  
  /// Cache key for storing user token
  static const String cachedUserTokenKey = 'CACHED_USER_TOKEN';
  
  /// Cache key for storing user data
  static const String cachedUserDataKey = 'CACHED_USER_DATA';
  
  /// Server error message
  static const String serverErrorMessage = 'Server error occurred. Please try again later.';
  
  /// Cache error message
  static const String cacheErrorMessage = 'Cache error occurred. Please try again later.';
  
  /// Network error message
  static const String networkErrorMessage = 'No internet connection. Please check your connection and try again.';
  
  /// Authentication error message
  static const String authErrorMessage = 'Authentication error. Please try again.';
  
  /// Unknown error message
  static const String unknownErrorMessage = 'Unknown error occurred. Please try again later.';
} 