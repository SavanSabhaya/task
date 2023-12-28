import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'detailpage_event.dart';
part 'detailpage_state.dart';

class DetailpageBloc extends Bloc<DetailpageEvent, DetailpageState> {
  DetailpageBloc() : super(DetailpageInitial()) {
    on<DetailpageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
