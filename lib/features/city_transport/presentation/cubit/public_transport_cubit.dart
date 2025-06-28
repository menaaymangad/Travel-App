import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_public_transport_info_usecase.dart';
import 'public_transport_state.dart';

class PublicTransportCubit extends Cubit<PublicTransportState> {
  final GetPublicTransportInfoUseCase getPublicTransportInfoUseCase;
  PublicTransportCubit({required this.getPublicTransportInfoUseCase})
      : super(PublicTransportInitial());

  Future<void> loadTransport({String? city}) async {
    emit(PublicTransportLoading());
    final result = await getPublicTransportInfoUseCase(
        GetPublicTransportInfoParams(city: city));
    result.fold(
      (failure) => emit(PublicTransportError(failure.message)),
      (list) => emit(PublicTransportLoaded(list)),
    );
  }
}
