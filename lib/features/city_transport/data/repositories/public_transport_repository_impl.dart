import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/public_transport.dart';
import '../../domain/repositories/public_transport_repository.dart';
import '../datasources/public_transport_remote_data_source.dart';

class PublicTransportRepositoryImpl implements PublicTransportRepository {
  final PublicTransportRemoteDataSource remoteDataSource;
  PublicTransportRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<PublicTransport>>> getPublicTransportInfo(
      {String? city}) async {
    try {
      final models = await remoteDataSource.getPublicTransportInfo(city: city);
      return Right(models);
    } catch (e) {
      return Left(
          ServerFailure(message: 'Failed to fetch public transport info'));
    }
  }
}
