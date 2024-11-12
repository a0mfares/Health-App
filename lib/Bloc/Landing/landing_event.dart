part of 'landing_bloc.dart';

abstract class LandingEvent {}

class BackInvocked extends LandingEvent {}

class LandingLoginPressed extends LandingEvent {}

class LandingSignUpPressed extends LandingEvent {}

class ForgetPasswordPressed extends LandingEvent {}

class ResetPassword extends LandingEvent {}
