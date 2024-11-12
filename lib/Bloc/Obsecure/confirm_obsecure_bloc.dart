import 'package:flutter_bloc/flutter_bloc.dart';
part 'confirm_obsecure_event.dart';
part 'confirm_obsecure_state.dart';

class ConfirmObsecureBloc
    extends Bloc<ConfirmObsecureEvent, ConfirmObsecureState> {
  ConfirmObsecureBloc() : super(ConfirmObsecured()) {
    on<ConfirmShowPassword>((event, emit) => emit(ConfirmVisible()));
    on<ConfirmHidePassword>((event, emit) => emit(ConfirmObsecured()));
  }
}
