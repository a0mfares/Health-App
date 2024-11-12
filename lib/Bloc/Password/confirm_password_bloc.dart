import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'confirm_password_state.dart';
part 'confirm_password_event.dart';

class ConfirmPasswordBloc
    extends Bloc<ConfirmPasswordEvent, ConfirmPasswordState> {
  final FocusNode focusNode;

  ConfirmPasswordBloc({required this.focusNode})
      : super(ConfirmPasswordInitial()) {
    on<ConfirmPasswordFocused>((event, emit) => emit(FocusedConfirmPassword()));
    on<ConfirmPasswordUnFocused>(
        (event, emit) => emit(UnFocusedConfirmPassword()));
    focusNode.addListener(() {
      add(focusNode.hasFocus
          ? ConfirmPasswordFocused()
          : ConfirmPasswordUnFocused());
    });
    on<ConfirmPasswordChanged>((event, emit) {
      final isMatched = event.password == event.confirmPassword;
      emit(ConfirmPasswordState(matched: isMatched));
    });
  }
}
