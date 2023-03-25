import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/input/button.dart';
import 'package:local/navigator/pre_auth/onboard/info_screen.dart';
import 'package:local/navigator/pre_auth/onboard/onboard_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/pages/account_info.dart';
import 'package:local/navigator/pre_auth/onboard/pages/basic_info.dart';
import 'package:local/navigator/pre_auth/onboard/pages/donation.dart';
import 'package:local/navigator/pre_auth/onboard/pages/interests.dart';
import 'package:local/navigator/pre_auth/onboard/pages/location_settings.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// constants
const basicInfoPage = 0;
const locationSettingsPage = 1;
const interestPage = 2;
const accountInfoPage = 3;
const donationPage = 4;

class OnboardNavigator extends StatefulWidget {
  const OnboardNavigator({Key? key}) : super(key: key);

  @override
  State<OnboardNavigator> createState() => _OnboardNavigatorState();
}

class _OnboardNavigatorState extends State<OnboardNavigator> {
  // controllers
  late PageController _pageController;
  final TextEditingController _nameController = TextEditingController();

  int _pageIndex = basicInfoPage;
  List<Widget> items = [];

  @override
  void initState() {
    _pageController = PageController(initialPage: basicInfoPage);

    items = [
      BasicInfo(
        nameController: _nameController,
      ),
      const LocationSettings(),
      const SelectInterestPage(),
      const AccountInfo(),
      const DonationPage(),
    ];
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardBloc>(
      create: (context) => OnboardBloc(),
      child: BlocConsumer<OnboardBloc, OnboardState>(
        listener: (context, state) {
          if (_pageIndex != items.length - 1 &&
              state.status == OnboardPageStatus.success) {
            context.read<OnboardBloc>().add(HandleNextPage());
            _pageController.nextPage(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 300));
          } else {}
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: TW3Colors.gray.shade700,
                leading: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: IconButton(
                    icon: Icon(
                      _pageIndex == basicInfoPage
                          ? Icons.close
                          : Icons.arrow_back_ios_new_rounded,
                    ),
                    color: TW3Colors.gray.shade300,
                    onPressed: () {
                      if (_pageIndex == basicInfoPage) {
                        Navigator.of(context).pop();
                      } else {
                        context.read<OnboardBloc>().add(HandleBackPage());
                        _pageController.previousPage(
                            curve: Curves.ease,
                            duration: const Duration(milliseconds: 300));
                      }
                    },
                  ),
                ),
                elevation: 0,
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    items.length,
                    (index) => Container(
                      padding: const EdgeInsets.all(4),
                      child: DotIndicator(
                        isActive: index == _pageIndex,
                      ),
                    ),
                  ),
                ),
              ),
              backgroundColor: TW3Colors.gray.shade700,
              body: SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          itemCount: items.length,
                          onPageChanged: (value) {
                            setState(() {
                              _pageIndex = value;
                            });
                          },
                          itemBuilder: (context, index) => items[index],
                        ),
                      ),
                      SafeArea(
                        child: CustomButton(
                          tap: () {
                            if (_pageIndex == basicInfoPage) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              context.read<OnboardBloc>().add(
                                    HandleBasicInfo(
                                      name: _nameController.text,
                                    ),
                                  );
                            } else if (_pageIndex == locationSettingsPage) {
                              context.read<OnboardBloc>().add(
                                    HandleLocationSettings(),
                                  );
                            }
                          },
                          text: _pageIndex == locationSettingsPage
                              ? "Next"
                              : _pageIndex != items.length - 1
                                  ? "Continue"
                                  : "Register",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
