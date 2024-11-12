import 'package:flutter_bloc/flutter_bloc.dart';
part 'obsecure_event.dart';
part 'obsecure_state.dart';

class ObsecureBloc extends Bloc<ObsecureEvent, ObsecureState> {
  ObsecureBloc() : super(Obsecured()) {
    on<ShowPassword>((event, emit) => emit(Visible()));
    on<HidePassword>((event, emit) => emit(Obsecured()));
  }
}
