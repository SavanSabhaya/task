part of 'zones_bloc.dart';

class ZonesState extends Equatable{
  const ZonesState({
    this.message = '',
    this.status = LoadStatus.initial,
  });

  final String message;
  final LoadStatus status;

  ZonesState copyWith({
    LoadStatus? status,
    String? message,
  }) {
    return ZonesState(
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