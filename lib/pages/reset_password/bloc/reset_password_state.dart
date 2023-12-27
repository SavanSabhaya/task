part of 'reset_password_bloc.dart';

class ResetPasswordState extends Equatable {
  const ResetPasswordState({this.message = '', this.status = LoadStatus.initial, this.isNewPasswordObscureText = true, this.isCnfPasswordObscureText = true});

  final String message;
  final LoadStatus status;
  final bool isNewPasswordObscureText;
  final bool isCnfPasswordObscureText;

  ResetPasswordState copyWith({
    LoadStatus? status,
    String? message,
    bool? isNewPasswordObscureText,
    bool? isCnfPasswordObscureText,
  }) {
    return ResetPasswordState(
        status: status ?? this.status,
        message: message ?? this.message,
        isNewPasswordObscureText: isNewPasswordObscureText ?? this.isNewPasswordObscureText,
        isCnfPasswordObscureText: isCnfPasswordObscureText ?? this.isCnfPasswordObscureText);
  }

  @override
  List<Object?> get props => [message, status, isNewPasswordObscureText, isCnfPasswordObscureText];
}
