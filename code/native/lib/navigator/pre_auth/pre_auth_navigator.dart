import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/components/input/button.dart';
import 'package:local/components/input/input.dart';
import 'package:local/shared/auth_feed/auth_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class PreAuthNavigator extends StatefulWidget {
  const PreAuthNavigator({Key? key}) : super(key: key);

  @override
  State<PreAuthNavigator> createState() => _PreAuthNavigatorState();
}

class _PreAuthNavigatorState extends State<PreAuthNavigator> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TW3Colors.gray.shade700,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomInput(
                controller: _emailController,
                placeholder: "Enter your email...",
              ),
              const SizedBox(
                height: 8,
              ),
              CustomInput(
                controller: _passwordController,
                placeholder: "Enter your password...",
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
    );
  }
}
