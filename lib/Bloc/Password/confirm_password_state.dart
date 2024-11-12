part of 'confirm_password_bloc.dart';

class ConfirmPasswordState {
  final bool matched;

  ConfirmPasswordState({
    this.matched = false,
  });

  ConfirmPasswordState copyWith({
    bool? matched,
  }) {
    return ConfirmPasswordState(
      matched: matched ?? this.matched,
    );
  }
}

class ConfirmPasswordInitial extends ConfirmPasswordState {}

class FocusedConfirmPassword extends ConfirmPasswordState {}

class UnFocusedConfirmPassword extends ConfirmPasswordState {}
