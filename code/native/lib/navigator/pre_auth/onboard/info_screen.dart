import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local/components/input/button.dart';
import 'package:local/navigator/pre_auth/onboard/onboard_navigator.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  final List<Info> pageData = [
    Info(
      image: "assets/svg/community_1.svg",
      title: "Get connected to your community",
      description: "Local give you an inside look into the people around you.",
    ),
    Info(
      image: "assets/svg/community_2.svg",
      title: "Find the people who keep you going",
      description: "Local give you an inside look into the people around you.",
    ),
    Info(
      image: "assets/svg/community_3.svg",
      title: "Do the things that make you happy",
      description: "Local give you an inside look into the people around you.",
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TW3Colors.gray.shade700,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            pageData.length,
            (index) => Container(
              padding: const EdgeInsets.all(4),
              child: DotIndicator(
                isActive: index == _pageIndex,
              ),
            ),
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: TW3Colors.gray.shade700,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pageData.length,
                  onPageChanged: (value) {
                    setState(() {
                      _pageIndex = value;
                    });
                  },
                  itemBuilder: (context, index) => InfoContent(
                    image: pageData[index].image,
                    title: pageData[index].title,
                    description: pageData[index].description,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SafeArea(
                child: CustomButton(
                  tap: () {
                    if (_pageIndex != pageData.length - 1) {
                      _pageController.nextPage(
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 300));
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const OnboardNavigator();
                          },
                        ),
                      );
                    }
                  },
                  text: _pageIndex != pageData.length - 1
                      ? "Next"
                      : "Get Started",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 250,
      ),
      height: 8,
      width: isActive ? 32 : 8,
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : TW3Colors.gray.shade500,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class Info {
  final String image, title, description;

  Info({
    required this.image,
    required this.title,
    required this.description,
  });
}

class InfoContent extends StatelessWidget {
  const InfoContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SvgPicture.asset(
          image,
          height: 250,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: TW3Colors.gray.shade300,
              ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Spacer(),
      ],
    );
  }
}
