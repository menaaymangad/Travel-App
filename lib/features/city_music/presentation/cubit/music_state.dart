import 'package:equatable/equatable.dart';
import '../../domain/entities/music.dart';

abstract class MusicState extends Equatable {
  const MusicState();
  @override
  List<Object?> get props => [];
}

class MusicInitial extends MusicState {}

class MusicLoading extends MusicState {}

class MusicLoaded extends MusicState {
  final List<Music> musics;
  const MusicLoaded(this.musics);
  @override
  List<Object?> get props => [musics];
}

class MusicError extends MusicState {
  final String message;
  const MusicError(this.message);
  @override
  List<Object?> get props => [message];
}
