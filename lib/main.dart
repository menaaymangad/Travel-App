import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart' as di;
import 'core/util/bloc_observer.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/register_page.dart';
import 'features/auth/presentation/pages/reset_password_page.dart';
import 'features/chat/presentation/pages/chat_details_page.dart';
import 'features/chat/presentation/pages/chat_page.dart';
import 'features/hotels/presentation/cubit/hotels_cubit.dart';
import 'features/hotels/presentation/pages/hotel_details_page.dart';
import 'features/hotels/presentation/pages/hotels_page.dart';
import 'features/landmarks/presentation/cubit/landmarks_cubit.dart';
import 'features/landmarks/presentation/pages/landmark_details_page.dart';
import 'features/landmarks/presentation/pages/landmarks_page.dart';
import 'features/map/presentation/pages/destinations_search_page.dart';
import 'features/map/presentation/pages/distance_calculator_page.dart';
import 'features/map/presentation/pages/map_page.dart';
import 'features/map/presentation/pages/places_details_page.dart';
import 'features/onboarding/presentation/pages/onboarding_page.dart';
import 'features/onboarding/presentation/pages/splash_page.dart';
import 'features/places/presentation/pages/place_details_page.dart';
import 'features/places/presentation/pages/places_page.dart';
import 'features/restaurants/presentation/cubit/restaurants_cubit.dart';
import 'features/restaurants/presentation/pages/restaurant_details_page.dart';
import 'features/restaurants/presentation/pages/restaurants_page.dart';
import 'features/social/presentation/pages/add_post_page.dart';
import 'features/social/presentation/pages/edit_profile_page.dart';
import 'features/social/presentation/pages/feeds_page.dart';
import 'features/social/presentation/pages/navigation_page.dart';
import 'features/social/presentation/pages/profile_page.dart';
import 'features/transport/presentation/pages/transport_cost_page.dart';
import 'features/transport/presentation/pages/transport_details_page.dart';
import 'features/weather/presentation/cubit/weather_cubit.dart';
import 'features/weather/presentation/pages/weather_details_page.dart';
import 'features/weather/presentation/pages/weather_page.dart';
import 'features/weather/presentation/pages/weather_search_page.dart';
import 'firebase_options.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize dependency injection
  await di.init();

  // Set up bloc observer
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

/// The main application widget
class MyApp extends StatelessWidget {
  /// Creates a new [MyApp] instance
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<LandmarksCubit>()),
        BlocProvider(create: (_) => di.sl<HotelsCubit>()),
        BlocProvider(create: (_) => di.sl<RestaurantsCubit>()),
        BlocProvider(create: (_) => di.sl<WeatherCubit>()),
      ],
      child: MaterialApp(
        title: 'Egypt Travel App',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        initialRoute: SplashPage.routeName,
        routes: {
          SplashPage.routeName: (context) => const SplashPage(),
          OnboardingPage.routeName: (context) => const OnboardingPage(),
          LoginPage.routeName: (context) => const LoginPage(),
          RegisterPage.routeName: (context) => const RegisterPage(),
          ResetPasswordPage.routeName: (context) => const ResetPasswordPage(),
          NavigationPage.routeName: (context) => const NavigationPage(),
          FeedsPage.routeName: (context) => const FeedsPage(),
          ProfilePage.routeName: (context) => const ProfilePage(),
          EditProfilePage.routeName: (context) => const EditProfilePage(),
          AddPostPage.routeName: (context) => const AddPostPage(),
          MapPage.routeName: (context) => const MapPage(),
          PlacesPage.routeName: (context) => const PlacesPage(),
          ChatPage.routeName: (context) => const ChatPage(),
          LandmarksPage.routeName: (context) => const LandmarksPage(),
          HotelsPage.routeName: (context) => const HotelsPage(),
          RestaurantsPage.routeName: (context) => const RestaurantsPage(),
          DestinationsSearchPage.routeName: (context) =>
              const DestinationsSearchPage(),
          DistanceCalculatorPage.routeName: (context) =>
              const DistanceCalculatorPage(),
          TransportCostPage.routeName: (context) => const TransportCostPage(),
          WeatherPage.routeName: (context) => const WeatherPage(),
          WeatherSearchPage.routeName: (context) => const WeatherSearchPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == PlacesDetailsPage.routeName) {
            final args = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => PlacesDetailsPage(placeId: args),
            );
          } else if (settings.name == PlaceDetailsPage.routeName) {
            final args = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => PlaceDetailsPage(placeId: args),
            );
          } else if (settings.name == ChatDetailsPage.routeName) {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => ChatDetailsPage(
                userId: args['userId'] as String,
                userName: args['userName'] as String,
              ),
            );
          } else if (settings.name == LandmarkDetailsPage.routeName) {
            final args = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => LandmarkDetailsPage(landmarkId: args),
            );
          } else if (settings.name == HotelDetailsPage.routeName) {
            final args = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => HotelDetailsPage(hotelId: args),
            );
          } else if (settings.name == RestaurantDetailsPage.routeName) {
            final args = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => RestaurantDetailsPage(restaurantId: args),
            );
          } else if (settings.name == TransportDetailsPage.routeName) {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => TransportDetailsPage(
                transportCost: args['transportCost'],
              ),
            );
          } else if (settings.name == WeatherDetailsPage.routeName) {
            final args = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => WeatherDetailsPage(cityName: args),
            );
          }
          return null;
        },
      ),
    );
  }
}
