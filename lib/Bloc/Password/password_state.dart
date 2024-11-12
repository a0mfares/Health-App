part of 'password_bloc.dart';

class PasswordState {
  final bool hasMinLength;
  final bool hasUpperLower;
  final bool hasNumber;
  final bool hasSpecialChar;
  final bool isEditing;

  PasswordState({
    this.hasMinLength = false,
    this.hasUpperLower = false,
    this.hasNumber = false,
    this.hasSpecialChar = false,
    this.isEditing = false,
  });

  PasswordState copyWith({
    bool? hasMinLength,
    bool? hasUpperLower,
    bool? hasNumber,
    bool? hasSpecialChar,
    bool? isEditing,
  }) {
    return PasswordState(
      hasMinLength: hasMinLength ?? this.hasMinLength,
      hasUpperLower: hasUpperLower ?? this.hasUpperLower,
      hasNumber: hasNumber ?? this.hasNumber,
      hasSpecialChar: hasSpecialChar ?? this.hasSpecialChar,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}

class PasswordInitial extends PasswordState {}

class FocusedPassword extends PasswordState {}

class UnFocusedPassword extends PasswordState {}
