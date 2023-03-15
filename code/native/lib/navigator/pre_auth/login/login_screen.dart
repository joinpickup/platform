import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/input/button.dart';
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStateStatus.authenticated) {
          Navigator.of(context).popUntil(
            (route) => route.isFirst,
          );
        }
      },
      child: Scaffold(
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
                  controller: _emailController,
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
                  decoration: BoxDecoration(
                    color: TW3Colors.gray.shade600,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                CupertinoTextField(
                  controller: _passwordController,
                  placeholder: "Enter your password...",
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
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomButton(
                  tap: () {
                    context.read<AuthBloc>().add(Login(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ));
                  },
                  text: "Login",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
