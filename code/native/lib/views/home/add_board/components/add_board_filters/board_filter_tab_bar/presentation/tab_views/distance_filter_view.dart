import 'package:flutter/material.dart';
import 'package:local/theme/color.dart';

class DistanceFilterView extends StatelessWidget {
  const DistanceFilterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: kColorInput,
          ),
          child: Center(child: Text("Distance")),
        ),
      ],
    );
  }
}
