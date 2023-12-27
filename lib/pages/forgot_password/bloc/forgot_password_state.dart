part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable{
  const ForgotPasswordState({
    this.message = '',
    this.status = LoadStatus.initial,
  });

  final String message;
  final LoadStatus status;

  ForgotPasswordState copyWith({
    LoadStatus? status,
    String? message,
    bool? isObscureText,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    message,
    status,
  ];
}