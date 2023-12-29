part of 'detailpage_bloc.dart';

class DetailpageState  {
  const DetailpageState({
    this.message = '',
    this.status = LoadStatus.initial,
this.data,
  });

  final String message;
  final LoadStatus status;
  final Product? data;

  DetailpageState copyWith({
    LoadStatus? status,
    String? message,
    Product? data,
  }) {
    return DetailpageState(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data??this.data,
    );
  }

  @override
  List<Object?> get props => [
        message,
        status,
        data,
      ];
}
class DetailpageIntial extends DetailpageState{}
