import 'package:equatable/equatable.dart';
import '../../domain/entities/post.dart';

/// Base state for social feature
abstract class SocialState extends Equatable {
  const SocialState();
  @override
  List<Object?> get props => [];
}

/// Initial state
class SocialInitial extends SocialState {}

/// Loading state
class SocialLoading extends SocialState {}

/// Error state
class SocialError extends SocialState {
  /// Error message
  final String message;

  /// Creates a new [SocialError] state
  const SocialError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Bottom navigation bar change state
class SocialChangeBottomNavState extends SocialState {}

class SocialPostsLoaded extends SocialState {
  final List<Post> posts;
  const SocialPostsLoaded(this.posts);
  @override
  List<Object?> get props => [posts];
}

class SocialPostUploaded extends SocialState {}
