import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'password_state.dart';
part 'password_event.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final FocusNode focusNode;

  PasswordBloc({required this.focusNode}) : super(PasswordInitial()) {
    final minLengthRegex = RegExp(r'^.{8,}$');
    final upperLowerRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])');
    final numberRegex = RegExp(r'^(?=.*\d)');
    final specialCharRegex = RegExp(r'^(?=.*[!@#\$&*~])');
    on<PasswordFocused>((event, emit) => emit(FocusedPassword()));
    on<PasswordUnFocused>((event, emit) => emit(UnFocusedPassword()));
    focusNode.addListener(() {
      add(focusNode.hasFocus ? PasswordFocused() : PasswordUnFocused());
    });
    on<PasswordChanged>((event, emit) => emit(PasswordState(
        hasMinLength: minLengthRegex.hasMatch(event.password),
        hasUpperLower: upperLowerRegex.hasMatch(event.password),
        hasNumber: numberRegex.hasMatch(event.password),
        hasSpecialChar: specialCharRegex.hasMatch(event.password),
        isEditing: true)));
  }
}
