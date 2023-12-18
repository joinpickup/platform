import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';

class TagsFilterView extends StatelessWidget {
  const TagsFilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Include",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: kColorInput,
            ),
            child: Wrap(
              children: [
                Button(
                  icon: kIconPlus,
                  click: () {},
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Exclude",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: kColorInput,
            ),
            child: Wrap(
              children: [
                Button(
                  icon: kIconPlus,
                  click: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.icon,
    required this.click,
    this.size = 36,
  });

  final String icon;
  final Function click;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        click();
      },
      child: Container(
        decoration: BoxDecoration(
          color: kColorInput.shade600,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              8,
            ),
          ),
        ),
        child: SvgPicture.string(
          icon,
          width: size,
          height: size,
          theme: SvgTheme(
            currentColor: kColorRoyal,
          ),
        ),
      ),
    );
  }
}
