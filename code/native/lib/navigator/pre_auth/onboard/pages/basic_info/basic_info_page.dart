import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:local/components/input/button.dart';
import 'package:local/navigator/pre_auth/onboard/onboard_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/pages/basic_info/basic_info_page_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class BasicInfoPage extends StatefulWidget {
  const BasicInfoPage({
    Key? key,
  }) : super(key: key);

  @override
  State<BasicInfoPage> createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends State<BasicInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  DateTime? birthday;

  @override
  void initState() {
    _nameController.text = context.read<BasicInfoPageBloc>().state.name ?? "";
    birthday = context.read<BasicInfoPageBloc>().state.birthday;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BasicInfoPageBloc, BasicInfoPageState>(
      bloc: context.read<BasicInfoPageBloc>(),
      listener: (context, state) {
        if (state.status == BasicInfoPageStatus.success) {
          context.read<BasicInfoPageBloc>().add(ResetBasicInfoValidation());
          context.read<OnboardBloc>().add(HandleNextPage());
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please give us some information to get started",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "You'll be able to change this later if need be...",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            const Spacer(),
            CupertinoTextField(
                keyboardType: TextInputType.emailAddress,
                controller: _nameController,
                onChanged: (value) => {
                      context
                          .read<BasicInfoPageBloc>()
                          .add(ResetBasicInfoValidation()),
                    },
                placeholder: "Enter your name...",
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
                  border: state.status == BasicInfoPageStatus.error &&
                          state.error == BasicInfoPageError.name
                      ? Border.all(
                          color: TW3Colors.red.shade500,
                          width: 2,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(8),
                )),
            const SizedBox(
              height: 8,
            ),
            CustomButton(
              hasError: state.status == BasicInfoPageStatus.error &&
                  state.error == BasicInfoPageError.birthday,
              buttonType: CustomButtonType.outlined,
              text: birthday == null
                  ? "Select your birthday."
                  : DateFormat.yMMMMd('en_US').format(birthday as DateTime),
              tap: () {
                showIOSDatePicker(context);
              },
            ),
            const Spacer(),
            SafeArea(
              child: CustomButton(
                  tap: () {
                    context.read<BasicInfoPageBloc>().add(
                          SubmitBasicInfo(
                            _nameController.text,
                            birthday,
                          ),
                        );
                  },
                  text: "Continue"),
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
                        .read<BasicInfoPageBloc>()
                        .add(ResetBasicInfoValidation());

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
