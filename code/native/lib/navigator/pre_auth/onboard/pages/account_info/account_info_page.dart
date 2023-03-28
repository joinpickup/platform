import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/input/button.dart';
import 'package:local/navigator/pre_auth/onboard/onboard_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/pages/account_info/account_info_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class AccountInfoPage extends StatefulWidget {
  const AccountInfoPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AccountInfoPage> createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showPassword = false;

  DateTime? birthday;

  @override
  void initState() {
    _emailController.text =
        context.read<AccountInfoPageBloc>().state.email ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountInfoPageBloc, AccountInfoPageState>(
      bloc: context.read<AccountInfoPageBloc>(),
      listener: (context, state) {
        if (state.status == AccountInfoPageStatus.success) {
          context.read<AccountInfoPageBloc>().add(ResetAccountInfoValidation());
          context.read<OnboardBloc>().add(HandleNextPage());
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "And finally, create your account",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            const Spacer(),
            CupertinoTextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              onChanged: (value) => {
                context
                    .read<AccountInfoPageBloc>()
                    .add(ResetAccountInfoValidation()),
              },
              placeholder: "Enter your email...",
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
                border: state.status == AccountInfoPageStatus.error &&
                        state.error?.errorType == AccountInfoPageErrorType.email
                    ? Border.all(
                        color: TW3Colors.red.shade500,
                        width: 2,
                      )
                    : null,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: CupertinoTextField(
                    obscureText: !showPassword,
                    controller: _passwordController,
                    onChanged: (value) => {
                      context
                          .read<AccountInfoPageBloc>()
                          .add(ResetAccountInfoValidation()),
                    },
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
                      border: state.status == AccountInfoPageStatus.error &&
                              state.error?.errorType ==
                                  AccountInfoPageErrorType.password
                          ? Border.all(
                              color: TW3Colors.red.shade500,
                              width: 2,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ],
            ),
            state.status == AccountInfoPageStatus.error &&
                    state.error?.errorType == AccountInfoPageErrorType.register
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
                            border:
                                state.status == AccountInfoPageStatus.error &&
                                        state.error?.errorType ==
                                            AccountInfoPageErrorType.register
                                    ? Border.all(
                                        color: TW3Colors.red.shade600,
                                        width: 2,
                                      )
                                    : null),
                        child: Text(
                          state.error?.error as String,
                          style: TextStyle(color: TW3Colors.gray.shade700),
                        ),
                      ),
                    ],
                  )
                : Container(),
            const Spacer(),
            SafeArea(
              child: CustomButton(
                  tap: () {
                    context.read<AccountInfoPageBloc>().add(
                          SubmitAccountInfo(
                            _emailController.text,
                            _passwordController.text,
                          ),
                        );
                  },
                  text: "Register"),
            ),
          ],
        );
      },
    );
  }

  void showIOSDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 400,
        padding: const EdgeInsets.all(8),
        color: TW3Colors.gray.shade700,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: birthday,
                  onDateTimeChanged: (DateTime newDateTime) {
                    context
                        .read<AccountInfoPageBloc>()
                        .add(ResetAccountInfoValidation());

                    setState(() {
                      birthday = newDateTime;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              CustomButton(
                text: "Confirm",
                tap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
