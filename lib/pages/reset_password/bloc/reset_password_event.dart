part of 'reset_password_bloc.dart';

@immutable
abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();
  @override
  List<Object?> get props => [];
}

class ResetNewPasswordChangedEvent extends ResetPasswordEvent {
  final bool isObscureText;
  const ResetNewPasswordChangedEvent(this.isObscureText);
}

class CnfNewPasswordChangedEvent extends ResetPasswordEvent {
  final bool isObscureText;
  const CnfNewPasswordChangedEvent(this.isObscureText);
}