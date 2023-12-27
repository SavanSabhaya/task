part of 'dashboard_bloc.dart';

class DashboardState extends Equatable{
  const DashboardState({
    this.message = '',
    this.status = LoadStatus.initial,
  });

  final String message;
  final LoadStatus status;

  DashboardState copyWith({
    LoadStatus? status,
    String? message,
  }) {
    return DashboardState(
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