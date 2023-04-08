import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/navigation/tab_bar/tab_bar_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TabBarBloc(),
        ),
      ],
      child: Scaffold(
        backgroundColor: TW3Colors.gray.shade700,
        appBar: AppBar(
          backgroundColor: TW3Colors.gray.shade700,
          elevation: 0,
          title: const Text("Chat"),
        ),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
