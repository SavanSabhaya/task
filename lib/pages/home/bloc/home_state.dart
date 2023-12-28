part of 'home_bloc.dart';

class HomeState extends Equatable{
  const HomeState({
    this.message = '',
    this.status = LoadStatus.initial,this.productListModel,
  });

  final String message;
  final LoadStatus status;
  final ProductListModel? productListModel;

  HomeState copyWith({
    LoadStatus? status,
    String? message,
    ProductListModel? productListModel
  }) {
    return HomeState(
      status: status ?? this.status,
      message: message ?? this.message,
      productListModel: productListModel??this.productListModel
    );
  }

  @override
  List<Object?> get props => [
    message,
    status,
    productListModel
  ];
}