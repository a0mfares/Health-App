part of 'landing_bloc.dart';

abstract class LandingState {}

class LandingInit extends LandingState {}

class LoginRequested extends LandingState {}

class SignUpRequested extends LandingState {}

class ForgotPassword extends LandingState {}

class ResetPasswordRequested extends LandingState {}
