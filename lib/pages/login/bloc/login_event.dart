part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class LoginPasswordChangedEvent extends LoginEvent {
  final bool isObscureText;
  const LoginPasswordChangedEvent(this.isObscureText);
}

class ValidateEvent extends LoginEvent {
  final String email;
  final String password;
  const ValidateEvent(this.email, this.password);
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password});
}
