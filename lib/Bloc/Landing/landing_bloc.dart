import 'package:flutter_bloc/flutter_bloc.dart';

part 'landing_state.dart';
part 'landing_event.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  LandingBloc() : super(LandingInit()) {
    on<LandingLoginPressed>((event, emit) {
      emit(LoginRequested());
    });
    on<LandingSignUpPressed>((event, emit) {
      emit(SignUpRequested());
    });
    on<BackInvocked>(((event, emit) {
      emit(LandingInit());
    }));

    on<ForgetPasswordPressed>(((event, emit) => emit(ForgotPassword())));

    on<ResetPassword>(((event, emit) => emit(ResetPasswordRequested())));
  }
}
