import 'package:equatable/equatable.dart';
import '../../domain/entities/public_transport.dart';

abstract class PublicTransportState extends Equatable {
  const PublicTransportState();
  @override
  List<Object?> get props => [];
}

class PublicTransportInitial extends PublicTransportState {}

class PublicTransportLoading extends PublicTransportState {}

class PublicTransportLoaded extends PublicTransportState {
  final List<PublicTransport> transports;
  const PublicTransportLoaded(this.transports);
  @override
  List<Object?> get props => [transports];
}

class PublicTransportError extends PublicTransportState {
  final String message;
  const PublicTransportError(this.message);
  @override
  List<Object?> get props => [message];
}
