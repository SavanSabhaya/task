part of 'detailpage_bloc.dart';

class DetailpageEvent  {
  const DetailpageEvent();

  @override
  List<Object> get props => [];
}

class DetailPageInitEvent extends DetailpageEvent {
  final Map<String, dynamic> data;
  DetailPageInitEvent(this.data);
}
