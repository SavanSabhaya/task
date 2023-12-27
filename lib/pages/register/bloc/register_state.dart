part of 'register_bloc.dart';

class RegisterState extends Equatable{
  const RegisterState({
    this.message = '',
    this.isObscureText = true,
    this.status = LoadStatus.initial,
  });

  final String message;
  final LoadStatus status;
  final bool isObscureText;

  RegisterState copyWith({
    LoadStatus? status,
    String? message,
    bool? isObscureText,
  }) {
    return RegisterState(
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