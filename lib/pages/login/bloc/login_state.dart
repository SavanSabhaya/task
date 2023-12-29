part of 'login_bloc.dart';

class LoginState  {
  LoginState({
    this.message = '',
    this.isObscureText = true,
    this.status = LoadStatus.initial,
    this.loginModel,
  });

  final String message;
  final LoadStatus status;
  final bool isObscureText;
  final LoginModel? loginModel;

  LoginState copyWith({
    LoadStatus? status,
    String? email,
    String? password,
    String? message,
    bool? isObscureText,
    LoginModel? loginModel
  }) {
    return LoginState(
      status: status ?? this.status,
      message: message ?? this.message,
      isObscureText: isObscureText ?? this.isObscureText,
      loginModel: loginModel??this.loginModel
    );
  }

  @override
  List<Object?> get props => [
        message,
        status,
        isObscureText,
        loginModel,
      ];
}
