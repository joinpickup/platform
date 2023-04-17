import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/input/button.dart';
import 'package:local/navigator/pre_auth/login/login_bloc.dart';
import 'package:local/repos/user_repository.dart';
import 'package:local/shared/auth_feed/auth_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(
            context.read<AuthBloc>().userRepository,
          ),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // need to check using the auth bloc to fully authenticate
          if (state.status == AuthStateStatus.authenticated) {
            Navigator.of(context).popUntil(
              (route) => route.isFirst,
            );
          }
        },
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            // if login is valid, have auth bloc handle it from here
            if (state.status == LoginScreenStatus.success) {
              context.read<AuthBloc>().add(
                    Authenticate(token: state.token as String),
                  );
            }
          },
          builder: (context, state) {
            bool hasError =
                state.status == LoginScreenStatus.error && state.error != null;
            LoginScreenErrorType? errorType = state.error?.errorType;

            return Scaffold(
              backgroundColor: TW3Colors.gray.shade700,
              appBar: AppBar(
                title: const Text("Login"),
                elevation: 0,
                backgroundColor: TW3Colors.gray.shade700,
              ),
              body: SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoTextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        onChanged: (value) =>
                            context.read<LoginBloc>().add(ResetValidation()),
                        placeholder: "Enter your email...",
                        placeholderStyle: TextStyle(
                          color: TW3Colors.gray.shade400,
                          fontFamily: "Nunito",
                        ),
                        style: TextStyle(
                          color: TW3Colors.gray.shade300,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.bold,
                        ),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: TW3Colors.gray.shade600,
                            borderRadius: BorderRadius.circular(8),
                            border: hasError &&
                                    errorType == LoginScreenErrorType.email
                                ? Border.all(
                                    color: TW3Colors.red.shade500,
                                    width: 2,
                                  )
                                : null),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CupertinoTextField(
                        controller: _passwordController,
                        obscureText: true,
                        onChanged: (value) =>
                            context.read<LoginBloc>().add(ResetValidation()),
                        placeholder: "Enter your password...",
                        padding: const EdgeInsets.all(12),
                        placeholderStyle: TextStyle(
                          color: TW3Colors.gray.shade400,
                          fontFamily: "Nunito",
                        ),
                        style: TextStyle(
                          color: TW3Colors.gray.shade300,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: BoxDecoration(
                            color: TW3Colors.gray.shade600,
                            borderRadius: BorderRadius.circular(8),
                            border: hasError &&
                                    errorType == LoginScreenErrorType.password
                                ? Border.all(
                                    color: TW3Colors.red.shade500,
                                    width: 2,
                                  )
                                : null),
                      ),
                      hasError && errorType == LoginScreenErrorType.submit
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: double.maxFinite,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: TW3Colors.red.shade400,
                                      borderRadius: BorderRadius.circular(8),
                                      border: hasError &&
                                              errorType ==
                                                  LoginScreenErrorType.submit
                                          ? Border.all(
                                              color: TW3Colors.red.shade600,
                                              width: 2,
                                            )
                                          : null),
                                  child: Text(
                                    state.error?.error as String,
                                    style: TextStyle(
                                        color: TW3Colors.gray.shade700),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          tap: () {
                            context.read<LoginBloc>().add(SubmitLogin(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ));
                          },
                          text: "Login",
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
