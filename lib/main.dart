import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health/Bloc/Landing/landing_bloc.dart';
import 'package:health/Bloc/Obsecure/confirm_obsecure_bloc.dart';
import 'package:health/Bloc/Obsecure/obsecure_bloc.dart';
import 'package:health/Bloc/Password/confirm_password_bloc.dart';
import 'package:health/Bloc/Password/password_bloc.dart';
import 'package:health/Screens/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ObsecureBloc>(
          create: (context) => ObsecureBloc(),
        ),
        BlocProvider<ConfirmPasswordBloc>(
          create: (context) => ConfirmPasswordBloc(focusNode: FocusNode()),
        ),
        BlocProvider<PasswordBloc>(
          create: (context) => PasswordBloc(focusNode: FocusNode()),
        ),
        BlocProvider<ConfirmObsecureBloc>(
          create: (context) => ConfirmObsecureBloc(),
        ),
        BlocProvider<LandingBloc>(
          create: (_) => LandingBloc(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Health Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: DoubleTapToExit(
          snackBar: SnackBar(
            animation: CurvedAnimation(
                curve: Curves.decelerate, parent: kAlwaysCompleteAnimation),
            behavior: SnackBarBehavior.floating,
            elevation: 2,
            width: MediaQuery.of(context).size.width * 0.45,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: const Center(child: Text('Tap again to exit !')),
          ),
          child: const LandingScreen(),
        ),
      ),
    );
  }
}
