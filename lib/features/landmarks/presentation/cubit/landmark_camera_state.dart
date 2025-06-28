import 'package:equatable/equatable.dart';

abstract class LandmarkCameraState extends Equatable {
  const LandmarkCameraState();
  @override
  List<Object?> get props => [];
}

class LandmarkCameraInitial extends LandmarkCameraState {}

class LandmarkCameraLoading extends LandmarkCameraState {}

class LandmarkCameraRecognized extends LandmarkCameraState {
  final String landmark;
  const LandmarkCameraRecognized(this.landmark);
  @override
  List<Object?> get props => [landmark];
}

class LandmarkCameraError extends LandmarkCameraState {
  final String message;
  const LandmarkCameraError(this.message);
  @override
  List<Object?> get props => [message];
}
