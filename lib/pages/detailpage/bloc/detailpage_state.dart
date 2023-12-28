part of 'detailpage_bloc.dart';

class DetailpageState extends Equatable {
  const DetailpageState({
    this.message = '',
    this.status = LoadStatus.initial,
  });

  final String message;
  final LoadStatus status;

  DetailpageState copyWith({
    LoadStatus? status,
    String? message,
  }) {
    return DetailpageState(
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
