part of 'home_bloc.dart';

class HomeState extends Equatable{
  const HomeState({
    this.message = '',
    this.status = LoadStatus.initial,
  });

  final String message;
  final LoadStatus status;

  HomeState copyWith({
    LoadStatus? status,
    String? message,
  }) {
    return HomeState(
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