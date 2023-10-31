import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BlackButton extends StatelessWidget {
  const BlackButton({
    super.key,
    required this.icon,
    required this.click,
  });

  final IconData icon;
  final Function click;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        click(context);
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.black,
          boxShadow: const [
            BoxShadow(
              offset: Offset(-1, 1),
              blurRadius: 8,
              color: Colors.black,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
