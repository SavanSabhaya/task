part of 'run_test_bloc.dart';

@immutable
abstract class RunTestEvent extends Equatable {
  const RunTestEvent();
  @override
  List<Object?> get props => [];
}

class SelectAllEvent extends RunTestEvent {
  final bool isCheck;
  const SelectAllEvent(this.isCheck);
}

class UpdateStatusEvent extends RunTestEvent {
  final bool isStart;
  const UpdateStatusEvent(this.isStart);
}