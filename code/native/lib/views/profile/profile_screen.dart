import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/theme/cubit/theme_cubit.dart';
import 'package:local/views/post/post_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            16.0,
            16.0,
            16.0,
            0.0,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CustomButton(
                      text: "Light",
                      click: () {
                        context.read<ThemeCubit>().setTheme(ThemeMode.light);
                      }),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomButton(
                      text: "Dark",
                      click: () {
                        context.read<ThemeCubit>().setTheme(ThemeMode.dark);
                      }),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomButton(
                      text: "System",
                      click: () {
                        context.read<ThemeCubit>().setTheme(ThemeMode.system);
                      }),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
