import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/onboard_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class BasicInfo extends StatefulWidget {
  const BasicInfo({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  final TextEditingController nameController;

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardBloc, OnboardState>(
      listener: (context, state) => {},
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: widget.nameController,
                  onChanged: (value) => {
                        context.read<OnboardBloc>().add(ResetErrors()),
                      },
                  placeholder: "Enter your name...",
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
                    border: state.status == OnboardPageStatus.error
                        ? Border.all(
                            color: TW3Colors.red.shade500,
                            width: 2,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(8),
                  )),
            ],
          ),
        );
      },
    );
  }
}
