import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelapp/core/network/network_info.dart';
import 'package:travelapp/core/util/input_converter.dart';
import 'package:travelapp/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:travelapp/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:travelapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:travelapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:travelapp/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:travelapp/features/auth/domain/usecases/is_signed_in_usecase.dart';
import 'package:travelapp/features/auth/domain/usecases/register_usecase.dart';
import 'package:travelapp/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:travelapp/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:travelapp/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:travelapp/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:travelapp/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:travelapp/features/hotels/data/datasources/hotel_local_data_source.dart';
import 'package:travelapp/features/hotels/data/datasources/hotel_remote_data_source.dart';
import 'package:travelapp/features/hotels/data/repositories/hotel_repository_impl.dart';
import 'package:travelapp/features/hotels/domain/repositories/hotel_repository.dart';
import 'package:travelapp/features/hotels/domain/usecases/filter_hotels_usecase.dart';
import 'package:travelapp/features/hotels/domain/usecases/get_hotels_by_city_usecase.dart';
import 'package:travelapp/features/hotels/domain/usecases/get_hotels_usecase.dart';
import 'package:travelapp/features/hotels/presentation/cubit/hotels_cubit.dart';
import 'package:travelapp/features/landmarks/data/datasources/landmark_local_data_source.dart';
import 'package:travelapp/features/landmarks/data/datasources/landmark_remote_data_source.dart';
import 'package:travelapp/features/landmarks/data/repositories/landmark_repository_impl.dart';
import 'package:travelapp/features/landmarks/domain/repositories/landmark_repository.dart';
import 'package:travelapp/features/landmarks/domain/usecases/get_landmarks_usecase.dart';
import 'package:travelapp/features/landmarks/presentation/cubit/landmarks_cubit.dart';
import 'package:travelapp/features/map/data/datasources/distance_remote_data_source.dart';
import 'package:travelapp/features/map/data/repositories/distance_repository_impl.dart';
import 'package:travelapp/features/map/domain/repositories/distance_repository.dart';
import 'package:travelapp/features/map/domain/usecases/calculate_distance_by_names_usecase.dart';
import 'package:travelapp/features/map/domain/usecases/calculate_distance_usecase.dart';
import 'package:travelapp/features/map/presentation/cubit/map_cubit.dart';
import 'package:travelapp/features/places/data/repositories/places_repository_impl.dart';
import 'package:travelapp/features/places/domain/repositories/places_repository.dart';
import 'package:travelapp/features/places/domain/usecases/filter_places_usecase.dart';
import 'package:travelapp/features/restaurants/data/datasources/restaurant_local_data_source.dart';
import 'package:travelapp/features/restaurants/data/datasources/restaurant_remote_data_source.dart';
import 'package:travelapp/features/restaurants/data/repositories/restaurant_repository_impl.dart';
import 'package:travelapp/features/restaurants/domain/repositories/restaurant_repository.dart';
import 'package:travelapp/features/restaurants/domain/usecases/filter_restaurants_usecase.dart';
import 'package:travelapp/features/restaurants/domain/usecases/get_restaurants_by_city_usecase.dart';
import 'package:travelapp/features/restaurants/domain/usecases/get_restaurants_usecase.dart';
import 'package:travelapp/features/restaurants/presentation/cubit/restaurants_cubit.dart';
import 'package:travelapp/features/social/data/datasources/social_remote_data_source.dart';
import 'package:travelapp/features/social/data/repositories/social_repository_impl.dart';
import 'package:travelapp/features/social/domain/repositories/social_repository.dart';
import 'package:travelapp/features/social/domain/usecases/fetch_posts_usecase.dart';
import 'package:travelapp/features/social/domain/usecases/upload_post_usecase.dart';
import 'package:travelapp/features/transport/data/datasources/transport_local_data_source.dart';
import 'package:travelapp/features/transport/data/datasources/transport_remote_data_source.dart';
import 'package:travelapp/features/transport/data/repositories/transport_repository_impl.dart';
import 'package:travelapp/features/transport/domain/repositories/transport_repository.dart';
import 'package:travelapp/features/transport/domain/usecases/calculate_transport_cost_usecase.dart';
import 'package:travelapp/features/transport/domain/usecases/get_transport_cost_by_type_usecase.dart';
import 'package:travelapp/features/transport/presentation/cubit/transport_cubit.dart';
import 'package:travelapp/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:travelapp/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:travelapp/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:travelapp/features/weather/domain/repositories/weather_repository.dart';
import 'package:travelapp/features/weather/domain/usecases/get_recent_searches_usecase.dart';
import 'package:travelapp/features/weather/domain/usecases/get_weather_forecast_by_location_usecase.dart';
import 'package:travelapp/features/weather/domain/usecases/get_weather_forecast_usecase.dart';
import 'package:travelapp/features/weather/domain/usecases/save_recent_search_usecase.dart';
import 'package:travelapp/features/weather/domain/usecases/search_cities_usecase.dart';
import 'package:travelapp/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:travelapp/features/trip_suggestions/data/datasources/trip_suggestion_remote_data_source.dart';
import 'package:travelapp/features/trip_suggestions/data/repositories/trip_suggestion_repository_impl.dart';
import 'package:travelapp/features/trip_suggestions/domain/repositories/trip_suggestion_repository.dart';
import 'package:travelapp/features/trip_suggestions/domain/usecases/get_trip_suggestions_usecase.dart';
import 'package:travelapp/features/trip_suggestions/presentation/cubit/trip_suggestions_cubit.dart';
import 'package:travelapp/features/city_transport/data/datasources/public_transport_remote_data_source.dart';
import 'package:travelapp/features/city_transport/data/repositories/public_transport_repository_impl.dart';
import 'package:travelapp/features/city_transport/domain/repositories/public_transport_repository.dart';
import 'package:travelapp/features/city_transport/domain/usecases/get_public_transport_info_usecase.dart';
import 'package:travelapp/features/city_transport/presentation/cubit/public_transport_cubit.dart';
import 'package:travelapp/features/city_music/data/datasources/music_remote_data_source.dart';
import 'package:travelapp/features/city_music/data/repositories/music_repository_impl.dart';
import 'package:travelapp/features/city_music/domain/repositories/music_repository.dart';
import 'package:travelapp/features/city_music/domain/usecases/get_city_music_usecase.dart';
import 'package:travelapp/features/city_music/presentation/cubit/music_cubit.dart';
import 'package:travelapp/features/landmarks/data/datasources/landmark_recognition_remote_data_source.dart';
import 'package:travelapp/features/landmarks/data/datasources/text_to_speech_data_source.dart';
import 'package:travelapp/features/landmarks/data/repositories/landmark_recognition_repository_impl.dart';
import 'package:travelapp/features/landmarks/data/repositories/text_to_speech_repository_impl.dart';
import 'package:travelapp/features/landmarks/domain/usecases/recognize_landmark_usecase.dart';
import 'package:travelapp/features/landmarks/domain/usecases/speak_text_usecase.dart';
import 'package:travelapp/features/landmarks/presentation/cubit/landmark_camera_cubit.dart';

import '../../features/social/presentation/cubit/social_cubit.dart';

/// Service locator instance
final sl = GetIt.instance;

/// Initialize dependencies
Future<void> init() async {
  // Features - Auth
  // Bloc/Cubit
  sl.registerFactory(
    () => AuthCubit(
      signInUseCase: sl(),
      registerUseCase: sl(),
      signOutUseCase: sl(),
      resetPasswordUseCase: sl(),
      getCurrentUserUseCase: sl(),
      isSignedInUseCase: sl(),
      inputConverter: sl(),
    ),
  );

  // Features - Social
  sl.registerFactory(() => SocialCubit(
        uploadPostUseCase: sl(),
        fetchPostsUseCase: sl(),
      ));
  sl.registerLazySingleton(() => UploadPostUseCase(sl()));
  sl.registerLazySingleton(() => FetchPostsUseCase(sl()));
  sl.registerLazySingleton<SocialRepository>(
    () => SocialRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<SocialRemoteDataSource>(
    () => SocialRemoteDataSourceImpl(
      firestore: FirebaseFirestore.instance,
      storage: FirebaseStorage.instance,
    ),
  );

  // Features - Map
  sl.registerFactory(
    () => MapCubit(
      calculateDistanceUseCase: sl(),
      calculateDistanceByNamesUseCase: sl(),
    ),
  );

  // Distance calculation
  sl.registerLazySingleton(() => CalculateDistanceUseCase(sl()));
  sl.registerLazySingleton(() => CalculateDistanceByNamesUseCase(sl()));
  sl.registerLazySingleton<DistanceRepository>(
    () => DistanceRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<DistanceRemoteDataSource>(
    () => DistanceRemoteDataSourceImpl(
      apiKey: 'YOUR_GOOGLE_MAPS_API_KEY', // Replace with your actual API key
    ),
  );

  // Features - Transport
  sl.registerFactory(
    () => TransportCubit(
      calculateTransportCostUseCase: sl(),
      getTransportCostByTypeUseCase: sl(),
    ),
  );

  // Transport cost calculation
  sl.registerLazySingleton(() => CalculateTransportCostUseCase(sl()));
  sl.registerLazySingleton(() => GetTransportCostByTypeUseCase(sl()));
  sl.registerLazySingleton<TransportRepository>(
    () => TransportRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<TransportRemoteDataSource>(
    () => TransportRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<TransportLocalDataSource>(
    () => TransportLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  // Features - Places
  sl.registerLazySingleton<PlacesRepository>(() => PlacesRepositoryImpl());
  sl.registerLazySingleton(() => FilterPlacesUseCase(sl()));

  // Features - Chat
  sl.registerFactory(() => ChatCubit());

  // Features - Landmarks
  sl.registerFactory(() => LandmarksCubit(getLandmarksUseCase: sl()));
  sl.registerLazySingleton(() => GetLandmarksUseCase(sl()));
  sl.registerLazySingleton<LandmarkRepository>(
    () => LandmarkRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<LandmarkRemoteDataSource>(
    () => LandmarkRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<LandmarkLocalDataSource>(
    () => LandmarkLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features - Hotels
  sl.registerFactory(
    () => HotelsCubit(
      getHotelsUseCase: sl(),
      getHotelsByCityUseCase: sl(),
      filterHotelsUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetHotelsUseCase(sl()));
  sl.registerLazySingleton(() => GetHotelsByCityUseCase(sl()));
  sl.registerLazySingleton(() => FilterHotelsUseCase(sl()));
  sl.registerLazySingleton<HotelRepository>(
    () => HotelRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<HotelRemoteDataSource>(
    () => HotelRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<HotelLocalDataSource>(
    () => HotelLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features - Restaurants
  sl.registerFactory(
    () => RestaurantsCubit(
      getRestaurantsUseCase: sl(),
      getRestaurantsByCityUseCase: sl(),
      filterRestaurantsUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetRestaurantsUseCase(sl()));
  sl.registerLazySingleton(() => GetRestaurantsByCityUseCase(sl()));
  sl.registerLazySingleton(() => FilterRestaurantsUseCase(sl()));
  sl.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<RestaurantRemoteDataSource>(
    () => RestaurantRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<RestaurantLocalDataSource>(
    () => RestaurantLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features - Weather
  sl.registerFactory(
    () => WeatherCubit(
      getWeatherForecastUseCase: sl(),
      getWeatherForecastByLocationUseCase: sl(),
      searchCitiesUseCase: sl(),
      getRecentSearchesUseCase: sl(),
      saveRecentSearchUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetWeatherForecastUseCase(sl()));
  sl.registerLazySingleton(() => GetWeatherForecastByLocationUseCase(sl()));
  sl.registerLazySingleton(() => SearchCitiesUseCase(sl()));
  sl.registerLazySingleton(() => GetRecentSearchesUseCase(sl()));
  sl.registerLazySingleton(() => SaveRecentSearchUseCase(sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(
      client: sl(),
      apiKey: 'YOUR_WEATHER_API_KEY', // Replace with your actual API key
    ),
  );
  sl.registerLazySingleton<WeatherLocalDataSource>(
    () => WeatherLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => IsSignedInUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      firestore: sl(),
    ),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Features - Trip Suggestions
  sl.registerFactory(
      () => TripSuggestionsCubit(getTripSuggestionsUseCase: sl()));
  sl.registerLazySingleton(() => GetTripSuggestionsUseCase(sl()));
  sl.registerLazySingleton<TripSuggestionRepository>(
    () => TripSuggestionRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<TripSuggestionRemoteDataSource>(
    () => TripSuggestionRemoteDataSourceImpl(),
  );

  // Features - City Transportation
  sl.registerFactory(
      () => PublicTransportCubit(getPublicTransportInfoUseCase: sl()));
  sl.registerLazySingleton(() => GetPublicTransportInfoUseCase(sl()));
  sl.registerLazySingleton<PublicTransportRepository>(
    () => PublicTransportRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<PublicTransportRemoteDataSource>(
    () => PublicTransportRemoteDataSourceImpl(),
  );

  // Features - City Music
  sl.registerFactory(() => MusicCubit(getCityMusicUseCase: sl()));
  sl.registerLazySingleton(() => GetCityMusicUseCase(sl()));
  sl.registerLazySingleton<MusicRepository>(
    () => MusicRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<MusicRemoteDataSource>(
    () => MusicRemoteDataSourceImpl(),
  );

  // Features - Landmark Camera Search
  sl.registerFactory(() => LandmarkCameraCubit(
        recognizeLandmarkUseCase: sl(),
        speakTextUseCase: sl(),
      ));
  sl.registerLazySingleton(() => RecognizeLandmarkUseCase(sl()));
  sl.registerLazySingleton(() => SpeakTextUseCase(sl()));
  sl.registerLazySingleton<LandmarkRecognitionRepository>(
    () => LandmarkRecognitionRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<LandmarkRecognitionRemoteDataSource>(
    () => LandmarkRecognitionRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<TextToSpeechRepository>(
    () => TextToSpeechRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<TextToSpeechDataSource>(
    () => TextToSpeechDataSourceImpl(),
  );
}
