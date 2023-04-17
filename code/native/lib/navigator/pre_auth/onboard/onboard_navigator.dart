import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/info_screen.dart';
import 'package:local/navigator/pre_auth/onboard/onboard_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/pages/account_info/account_info_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/pages/account_info/account_info_page.dart';
import 'package:local/navigator/pre_auth/onboard/pages/basic_info/basic_info_page.dart';
import 'package:local/navigator/pre_auth/onboard/pages/basic_info/basic_info_page_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/pages/donation/donation_page.dart';
import 'package:local/navigator/pre_auth/onboard/pages/interests/interests_page.dart';
import 'package:local/navigator/pre_auth/onboard/pages/interests/interests_page_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/pages/location_settings/location_settings_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/pages/location_settings/location_settings_page.dart';
import 'package:local/repos/user_repository.dart';
import 'package:local/shared/auth_feed/auth_bloc.dart';
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

  int _pageIndex = basicInfoPage;
  List<Widget> items = [];

  @override
  void initState() {
    _pageController = PageController(initialPage: basicInfoPage);

    items = [
      const BasicInfoPage(),
      const LocationSettingsPage(),
      const SelectInterestPage(),
      const AccountInfoPage(),
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnboardBloc(),
        ),
        BlocProvider(
          create: (context) => BasicInfoPageBloc(),
        ),
        BlocProvider(
          create: (context) => InterestsPageBloc(),
        ),
        BlocProvider(
          create: (context) => LocationSettingsPageBloc(),
        ),
        BlocProvider(
          create: (context) => AccountInfoPageBloc(
            context.read<AuthBloc>().userRepository,
          ),
        ),
      ],
      child: BlocConsumer<OnboardBloc, OnboardState>(
        listener: (context, state) {
          if (_pageIndex != items.length - 1 &&
              state.status == OnboardPageStatus.success) {
            context.read<OnboardBloc>().add(ResetOnboardPage());

            // if we are on the account page, try authenticating
            if (_pageIndex == accountInfoPage &&
                state.status == OnboardPageStatus.success) {
              context.read<AuthBloc>().add(
                    Authenticate(
                        token: context.read<AccountInfoPageBloc>().state.token
                            as String),
                  );
            }

            FocusManager.instance.primaryFocus?.unfocus();
            _pageController.nextPage(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 400));
          }
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
                      _pageIndex == basicInfoPage || _pageIndex == donationPage
                          ? Icons.close
                          : Icons.arrow_back_ios_new_rounded,
                    ),
                    color: TW3Colors.gray.shade300,
                    onPressed: () {
                      if (_pageIndex == basicInfoPage) {
                        Navigator.of(context).pop();
                      } else if (_pageIndex == donationPage) {
                        Navigator.of(context).popUntil(
                          (route) => route.isFirst,
                        );
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
                title: _pageIndex == donationPage
                    ? null
                    : Row(
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
