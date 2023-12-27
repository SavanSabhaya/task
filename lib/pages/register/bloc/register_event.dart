part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
  @override
  List<Object?> get props => [];
}

class RegisterPasswordChangedEvent extends RegisterEvent {
  final bool isObscureText;
  const RegisterPasswordChangedEvent(this.isObscureText);
}