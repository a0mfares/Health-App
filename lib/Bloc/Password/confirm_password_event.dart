part of 'confirm_password_bloc.dart';

abstract class ConfirmPasswordEvent {}

class ConfirmPasswordChanged extends ConfirmPasswordEvent {
  final String password;
  final String confirmPassword;
  ConfirmPasswordChanged(this.password, this.confirmPassword);
}

class ConfirmPasswordFocused extends ConfirmPasswordEvent {}

class ConfirmPasswordUnFocused extends ConfirmPasswordEvent {}
