import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health/Bloc/Landing/landing_bloc.dart';
import 'package:health/Bloc/Obsecure/confirm_obsecure_bloc.dart';
import 'package:health/Bloc/Obsecure/obsecure_bloc.dart';
import 'package:health/Bloc/Password/confirm_password_bloc.dart';
import 'package:health/Bloc/Password/password_bloc.dart';
import 'package:health/Constants/colors.dart';
import 'package:health/Constants/images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _emailcontroller = TextEditingController();
final _namecontroller = TextEditingController();
final _passwordcontroller = TextEditingController();
final _signuppasswordcontroller = TextEditingController();
final _signupconfirmpasswordcontroller = TextEditingController();
final db = FirebaseFirestore.instance;

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(20), child: Container()),
      backgroundColor: Colors.white,
      body: BlocConsumer<LandingBloc, LandingState>(
          listener: (context, state) {},
          builder: (context, state) {
            return _buildContent(state, context);
          }),
    );
  }
}

Widget _buildContent(LandingState state, BuildContext context) {
  Widget content;

  if (state is LandingInit) {
    content = _buildInitContnet(context);
  } else if (state is LoginRequested) {
    content = _buildLoginContent(context);
  } else if (state is SignUpRequested) {
    content = _buildSignUpContent(context);
  } else if (state is ForgotPassword) {
    content = _buildForgotPassword(context);
  } else if (state is ResetPasswordRequested) {
    content = _buildResetPassword(context);
  } else {
    content = const Center(
      key: ValueKey('fallback'),
      child: Text(
        "Loading...",
        style:
            TextStyle(color: purple, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  return content;
}

Widget _buildInitContnet(BuildContext context) {
  return SingleChildScrollView(
    child: Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          key: const ValueKey('initial'),
          children: [
            const Text(
              "Welcome to",
              style: TextStyle(
                  color: purple, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Self Care",
              style: TextStyle(
                  color: purple, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.4,
                margin: const EdgeInsets.only(bottom: 80),
                child: welcome),
            ElevatedButton(
              onPressed: () {
                context.read<LandingBloc>().add(LandingSignUpPressed());
              },
              style: ElevatedButton.styleFrom(
                  maximumSize: const Size(350, 150),
                  minimumSize: const Size(300, 50),
                  backgroundColor: purple,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide.none)),
              child: const Text(
                "Sign Up",
                style: TextStyle(
                    color: white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                context.read<LandingBloc>().add(LandingLoginPressed());
              },
              style: ElevatedButton.styleFrom(
                  maximumSize: const Size(350, 150),
                  minimumSize: const Size(300, 50),
                  backgroundColor: white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide(color: purple))),
              child: const Text(
                "Login",
                style: TextStyle(
                    color: purple, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    ),
  );
}

Widget _buildLoginContent(BuildContext context) {
  return SingleChildScrollView(
    child: Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          key: const ValueKey('Login'),
          children: [
            const Text(
              "Hello Beautiful",
              style: TextStyle(
                  color: purple, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Login",
              style: TextStyle(
                  color: purple, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.4,
                margin: const EdgeInsets.only(bottom: 40),
                child: welcome),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                controller: _emailcontroller,
                decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                            width: 2,
                            color: Color.fromRGBO(237, 236, 244, 1)))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<ObsecureBloc, ObsecureState>(
              builder: (context, state) {
                bool obscured = state is Obsecured;
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextField(
                    controller: _passwordcontroller,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            state is Obsecured?
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 24,
                          ),
                          onPressed: () {
                            if (state is Obsecured) {
                              context.read<ObsecureBloc>().add(ShowPassword());
                            } else {
                              context.read<ObsecureBloc>().add(HidePassword());
                            }
                          },
                        ),
                        hintText: 'Password',
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 2,
                                color: Color.fromRGBO(237, 236, 244, 1)))),
                    obscureText: obscured,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.48),
              child: InkWell(
                child: const Text(
                  "Forgot Password ?",
                  style: TextStyle(color: purple, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  context.read<LandingBloc>().add(ForgetPasswordPressed());
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  maximumSize: const Size(350, 150),
                  minimumSize: const Size(300, 50),
                  backgroundColor: purple,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide.none)),
              child: const Text(
                "Login",
                style: TextStyle(
                    color: white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account ?"),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: const Text(
                    "Sign Up",
                    style:
                        TextStyle(color: purple, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    context.read<LandingBloc>().add(LandingSignUpPressed());
                  },
                )
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    ),
  );
}

Widget _buildSignUpContent(BuildContext context) {
  return SingleChildScrollView(
    child: Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          key: const ValueKey('SignUp'),
          children: [
            const Text(
              "Hello Beautiful",
              style: TextStyle(
                  color: purple, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Sign Up",
              style: TextStyle(
                  color: purple, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.3,
                margin: const EdgeInsets.only(bottom: 10),
                child: welcome),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                controller: _namecontroller,
                decoration: const InputDecoration(
                    hintText: 'Full Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                            width: 2,
                            color: Color.fromRGBO(237, 236, 244, 1)))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                controller: _emailcontroller,
                decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                            width: 2,
                            color: Color.fromRGBO(237, 236, 244, 1)))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<ObsecureBloc, ObsecureState>(
              builder: (context, state) {
                bool obscured = state is Obsecured;
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextField(
                    controller: _signuppasswordcontroller,
                    focusNode: context.read<PasswordBloc>().focusNode,
                    onEditingComplete: () {
                      context.read<PasswordBloc>().add(PasswordFocused());
                    },
                    onChanged: (password) {
                      context.read<PasswordBloc>().add(PasswordFocused());
                      context
                          .read<PasswordBloc>()
                          .add(PasswordChanged(password));
                    },
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            state is Obsecured?
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 24,
                          ),
                          onPressed: () {
                            if (state is Obsecured) {
                              context.read<ObsecureBloc>().add(ShowPassword());
                            } else {
                              context.read<ObsecureBloc>().add(HidePassword());
                            }
                          },
                        ),
                        hintText: 'Password',
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 2,
                                color: Color.fromRGBO(237, 236, 244, 1)))),
                    obscureText: obscured,
                  ),
                );
              },
            ),
            BlocBuilder<PasswordBloc, PasswordState>(builder: (context, state) {
              if (context.read<PasswordBloc>().focusNode.hasFocus) {
                return Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10),
                  child: Column(
                    children: [
                      _buildConditionRow(
                        'At least 8 characters',
                        state.hasMinLength,
                      ),
                      _buildConditionRow(
                        'Contains uppercase and lowercase letters',
                        state.hasUpperLower,
                      ),
                      _buildConditionRow(
                        'Includes a number',
                        state.hasNumber,
                      ),
                      _buildConditionRow(
                        'Has a special character (e.g., @, #, \$)',
                        state.hasSpecialChar,
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<ConfirmObsecureBloc, ConfirmObsecureState>(
              builder: (context, state) {
                bool obscured = state is ConfirmObsecured;
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextField(
                    controller: _signupconfirmpasswordcontroller,
                    focusNode: context.read<ConfirmPasswordBloc>().focusNode,
                    onEditingComplete: () {
                      context
                          .read<ConfirmPasswordBloc>()
                          .add(ConfirmPasswordFocused());
                    },
                    onChanged: (password) {
                      context
                          .read<ConfirmPasswordBloc>()
                          .add(ConfirmPasswordFocused());
                      context.read<ConfirmPasswordBloc>().add(
                          ConfirmPasswordChanged(
                              _passwordcontroller.text, password));
                    },
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            state is ConfirmObsecured
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 24,
                          ),
                          onPressed: () {
                            if (state is ConfirmObsecured) {
                              context
                                  .read<ConfirmObsecureBloc>()
                                  .add(ConfirmShowPassword());
                            } else {
                              context
                                  .read<ConfirmObsecureBloc>()
                                  .add(ConfirmHidePassword());
                            }
                          },
                        ),
                        hintText: 'Confirm Password',
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 2,
                                color: Color.fromRGBO(237, 236, 244, 1)))),
                    obscureText: obscured,
                  ),
                );
              },
            ),
            BlocBuilder<ConfirmPasswordBloc, ConfirmPasswordState>(
                builder: (context, state) {
              if (context.read<ConfirmPasswordBloc>().focusNode.hasFocus) {
                return Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10),
                  child: _buildConditionRow(
                    'Password Matches',
                    state.matched,
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                final user = <String, dynamic>{
                  "Name": _namecontroller.text,
                  "Email": _emailcontroller.text,
                  "Password": _passwordcontroller
                };
                db.collection("Users").add(user).then((DocumentReference doc) =>
                    debugPrint('DocumentSnapshot added with ID: ${doc.id}'));
              },
              style: ElevatedButton.styleFrom(
                  maximumSize: const Size(350, 150),
                  minimumSize: const Size(300, 50),
                  backgroundColor: purple,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide.none)),
              child: const Text(
                "Sign Up",
                style: TextStyle(
                    color: white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account ?"),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: const Text(
                    "Login",
                    style:
                        TextStyle(color: purple, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    context.read<LandingBloc>().add(LandingLoginPressed());
                  },
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

_buildConditionRow(String text, bool isMet) {
  return Row(
    children: [
      Icon(
        isMet ? Icons.check_circle : Icons.cancel,
        color: isMet ? Colors.green : Colors.red,
        size: 20,
      ),
      const SizedBox(width: 8),
      Text(
        text,
        style: TextStyle(
          color: isMet ? Colors.green : Colors.red,
        ),
      ),
    ],
  );
}

Widget _buildForgotPassword(BuildContext context) {
  return SingleChildScrollView(
    child: Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          key: const ValueKey('Login'),
          children: [
            const Spacer(),
            Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.4,
                margin: const EdgeInsets.only(bottom: 40),
                child: welcome),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                controller: _emailcontroller,
                decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                            width: 2,
                            color: Color.fromRGBO(237, 236, 244, 1)))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<LandingBloc>().add(ResetPassword());
              },
              style: ElevatedButton.styleFrom(
                  maximumSize: const Size(350, 150),
                  minimumSize: const Size(300, 50),
                  backgroundColor: purple,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide.none)),
              child: const Text(
                "Reset Password",
                style: TextStyle(
                    color: white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    ),
  );
}

Widget _buildResetPassword(BuildContext context) {
  return SingleChildScrollView(
    child: Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          key: const ValueKey('SignUp'),
          children: [
            const Spacer(),
            Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.3,
                margin: const EdgeInsets.only(bottom: 10),
                child: welcome),
            BlocBuilder<ObsecureBloc, ObsecureState>(
              builder: (context, state) {
                bool obscured = state is Obsecured;
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextField(
                    controller: _signuppasswordcontroller,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            state is Obsecured?
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 24,
                          ),
                          onPressed: () {
                            if (state is Obsecured) {
                              context.read<ObsecureBloc>().add(ShowPassword());
                            } else {
                              context.read<ObsecureBloc>().add(HidePassword());
                            }
                          },
                        ),
                        hintText: 'New Password',
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 2,
                                color: Color.fromRGBO(237, 236, 244, 1)))),
                    obscureText: obscured,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<ConfirmObsecureBloc, ConfirmObsecureState>(
              builder: (context, state) {
                bool obscured = state is ConfirmObsecured;
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextField(
                    controller: _signupconfirmpasswordcontroller,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            state is ConfirmObsecured
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 24,
                          ),
                          onPressed: () {
                            if (state is ConfirmObsecured) {
                              context
                                  .read<ConfirmObsecureBloc>()
                                  .add(ConfirmShowPassword());
                            } else {
                              context
                                  .read<ConfirmObsecureBloc>()
                                  .add(ConfirmHidePassword());
                            }
                          },
                        ),
                        hintText: 'Confirm New Password',
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                width: 2,
                                color: Color.fromRGBO(237, 236, 244, 1)))),
                    obscureText: obscured,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<LandingBloc>().add(LandingLoginPressed());
              },
              style: ElevatedButton.styleFrom(
                  maximumSize: const Size(350, 150),
                  minimumSize: const Size(300, 50),
                  backgroundColor: purple,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide.none)),
              child: const Text(
                "Set New Passwod",
                style: TextStyle(
                    color: white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    ),
  );
}
