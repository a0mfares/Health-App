part of 'password_bloc.dart';

abstract class PasswordEvent {}

class PasswordChanged extends PasswordEvent {
  final String password;
  PasswordChanged(this.password);
}

class PasswordFocused extends PasswordEvent {}

class PasswordUnFocused extends PasswordEvent {}
