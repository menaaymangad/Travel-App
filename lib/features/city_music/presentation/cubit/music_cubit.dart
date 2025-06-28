import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_city_music_usecase.dart';
import 'music_state.dart';

class MusicCubit extends Cubit<MusicState> {
  final GetCityMusicUseCase getCityMusicUseCase;
  MusicCubit({required this.getCityMusicUseCase}) : super(MusicInitial());

  Future<void> loadMusic({String? city}) async {
    emit(MusicLoading());
    final result = await getCityMusicUseCase(GetCityMusicParams(city: city));
    result.fold(
      (failure) => emit(MusicError(failure.message)),
      (list) => emit(MusicLoaded(list)),
    );
  }
}
