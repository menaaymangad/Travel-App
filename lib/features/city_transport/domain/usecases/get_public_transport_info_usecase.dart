import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/public_transport.dart';
import '../repositories/public_transport_repository.dart';

class GetPublicTransportInfoParams {
  final String? city;
  const GetPublicTransportInfoParams({this.city});
}

class GetPublicTransportInfoUseCase
    implements UseCase<List<PublicTransport>, GetPublicTransportInfoParams> {
  final PublicTransportRepository repository;
  GetPublicTransportInfoUseCase(this.repository);

  @override
  Future<Either<Failure, List<PublicTransport>>> call(
      GetPublicTransportInfoParams params) {
    return repository.getPublicTransportInfo(city: params.city);
  }
}
