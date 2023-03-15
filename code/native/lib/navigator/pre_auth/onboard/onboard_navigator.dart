import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/onboard_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/pages/basic_info.dart';
import 'package:local/navigator/pre_auth/onboard/pages/cancel_dialog.dart';

class OnboardNavigator extends StatelessWidget {
  const OnboardNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardBloc>(
      create: (context) => OnboardBloc(),
      child: BlocConsumer<OnboardBloc, OnboardState>(
        builder: (context, state) {
          switch (state.page) {
            case OnboardPage.basicInfo:
              return const BasicInfo();
            default:
              return Container();
          }
        },
        listener: (context, state) => {
          if (state.onboardDialog)
            {
              showDialog(
                context: context,
                builder: (context) => const CancelDialog(),
              )
            }
        },
      ),
    );
  }
}
// WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         backgroundColor: TW3Colors.gray.shade700,
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.close),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           backgroundColor: TW3Colors.gray.shade700,
//           elevation: 0,
//         ),
//         body: SafeArea(
//           child: Container(),
//         ),
//       ),
//     )
