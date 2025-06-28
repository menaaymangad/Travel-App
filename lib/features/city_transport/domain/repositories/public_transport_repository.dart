import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/public_transport.dart';

abstract class PublicTransportRepository {
  Future<Either<Failure, List<PublicTransport>>> getPublicTransportInfo(
      {String? city});
}
