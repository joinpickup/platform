import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> showSearchBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    context: context,
    builder: (context) {
      return const SearchSheet();
    },
  );
}

class SearchSheet extends StatelessWidget {
  const SearchSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 700,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // pull down thingy
            Container(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black,
                ),
                width: 64,
                height: 4,
              ),
            ),
            // search bar
            const CupertinoSearchTextField(),
          ],
        ),
      ),
    );
  }
}
