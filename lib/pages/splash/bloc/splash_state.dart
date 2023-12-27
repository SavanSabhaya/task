part of 'splash_bloc.dart';

class SplashState extends Equatable {
  const SplashState({
    this.message = '',
    this.status = LoadStatus.initial,
  });
  final String message;
  final LoadStatus status;

  SplashState copyWith({
    LoadStatus? status,
    String? message,
  }) {
    return SplashState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    message,
    status,
  ];
}