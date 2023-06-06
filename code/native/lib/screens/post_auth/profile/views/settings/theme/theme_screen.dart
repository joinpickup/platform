import 'package:flutter/material.dart';
import 'package:local/components/input/button.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class ChangeThemeScreen extends StatefulWidget {
  const ChangeThemeScreen({super.key});

  @override
  State<ChangeThemeScreen> createState() => _ChangeThemeScreenState();
}

class _ChangeThemeScreenState extends State<ChangeThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Theme"),
        elevation: 0,
      ),
      backgroundColor: TW3Colors.gray.shade600,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          _buildProfileSettings(context),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: TW3Colors.gray.shade600,
                  child: CustomButton(
                    buttonType: CustomButtonType.contained,
                    tap: () {},
                    text: "Update",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildProfileSettings(BuildContext context) {
  return Column(
    children: const [
      SelectableTheme(),
      SizedBox(
        height: 8,
      ),
      SelectableTheme(),
      SizedBox(
        height: 8,
      ),
      SelectableTheme(),
    ],
  );
}

class SelectableTheme extends StatelessWidget {
  const SelectableTheme({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
