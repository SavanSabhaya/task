part of 'login_bloc.dart';

class LoginState extends Equatable {
  LoginState({
    this.message = '',
    this.isObscureText = true,
    this.status = LoadStatus.initial,
  });

  final String message;
  final LoadStatus status;
  final bool isObscureText;

  LoginState copyWith({
    LoadStatus? status,
    String? email,
    String? password,
    String? message,
    bool? isObscureText,
  }) {
    return LoginState(
      status: status ?? this.status,
      message: message ?? this.message,
      isObscureText: isObscureText ?? this.isObscureText,
    );
  }

  @override
  List<Object?> get props => [
        message,
        status,
        isObscureText,
      ];
}
