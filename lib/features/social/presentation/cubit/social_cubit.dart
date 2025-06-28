import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/core/usecases/usecase.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/upload_post_usecase.dart';
import '../../domain/usecases/fetch_posts_usecase.dart';
import 'social_state.dart';
import '../../../chat/presentation/pages/chat_page.dart';
import '../../../hotels/presentation/pages/hotels_page.dart';
import '../../../landmarks/presentation/pages/landmarks_page.dart';
import '../../../map/presentation/pages/map_page.dart';
import '../../../places/presentation/pages/places_page.dart';
import '../../../restaurants/presentation/pages/restaurants_page.dart';
import '../../../transport/presentation/pages/transport_cost_page.dart';
import '../pages/feeds_page.dart';
import '../pages/profile_page.dart';

/// Cubit for handling social feature state
class SocialCubit extends Cubit<SocialState> {
  final UploadPostUseCase uploadPostUseCase;
  final FetchPostsUseCase fetchPostsUseCase;

  /// Creates a new [SocialCubit] instance
  SocialCubit({
    required this.uploadPostUseCase,
    required this.fetchPostsUseCase,
  }) : super(SocialInitial());

  /// Gets the instance of [SocialCubit]
  static SocialCubit get(context) => BlocProvider.of(context);

  /// Current index of the bottom navigation bar
  int currentIndex = 0;

  /// Screens to be displayed based on the bottom navigation bar index
  final List<Widget> screens = [
    const FeedsPage(),
    const PlacesPage(),
    const LandmarksPage(),
    const HotelsPage(),
    const RestaurantsPage(),
    const MapPage(),
    const TransportCostPage(),
    const ChatPage(),
    const ProfilePage(),
  ];

  /// Changes the bottom navigation bar index
  void changeBottomNav(int index) {
    currentIndex = index;
    emit(SocialChangeBottomNavState());
  }

  Future<void> uploadPost(Post post, {String? imagePath}) async {
    emit(SocialLoading());
    final result = await uploadPostUseCase(
        UploadPostParams(post: post, imagePath: imagePath));
    result.fold(
      (failure) => emit(SocialError(failure.message)),
      (_) => emit(SocialPostUploaded()),
    );
  }

  Future<void> fetchPosts() async {
    emit(SocialLoading());
    final result = await fetchPostsUseCase(NoParams());
    result.fold(
      (failure) => emit(SocialError(failure.message)),
      (posts) => emit(SocialPostsLoaded(posts)),
    );
  }
}
