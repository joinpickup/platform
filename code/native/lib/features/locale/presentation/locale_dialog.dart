import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/features/locale/application/locale_bloc/locale_bloc_bloc.dart';

class LocaleDialog extends StatefulWidget {
  const LocaleDialog({Key? key}) : super(key: key);

  @override
  State<LocaleDialog> createState() => _LocaleDialogState();
}

class _LocaleDialogState extends State<LocaleDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LocaleBloc, LocalState>(
        listener: (context, state) {},
        child: SafeArea(
          child: Container(
            child: Text("Test"),
          ),
        ),
      ),
    );
  }
}
