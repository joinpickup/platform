import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';
import 'package:local/views/home/add_board/components/visibility_selector/cubit/visibility_selector_cubit.dart';

class VisibilitySelector extends StatelessWidget {
  const VisibilitySelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisibilitySelectorCubit, VisibilityOption>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: VisibilityOption.values.map(
            (e) {
              return Row(
                children: [
                  VisibilityOptionView(
                    selected: e == state,
                    option: e,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              );
            },
          ).toList(),
        );
      },
    );
  }
}

class VisibilityOptionView extends StatelessWidget {
  const VisibilityOptionView({
    super.key,
    required this.option,
    required this.selected,
  });

  final VisibilityOption option;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<VisibilitySelectorCubit>().changeOption(option);
      },
      child: Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          border: Border.all(
              width: 2, color: selected ? kColorRoyal : Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            children: [
              SvgPicture.string(
                option.icon,
                width: 36,
                height: 36,
                theme: SvgTheme(
                  currentColor: selected ? kColorRoyal : Colors.grey.shade400,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                option.text,
                style: TextStyle(
                  color: selected ? kColorRoyal : Colors.grey.shade400,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
