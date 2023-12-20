import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/components/icon_button.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';
import 'package:local/views/home/add_board/components/add_board_filters/cubit/add_board_filters_cubit.dart';
import 'package:local/views/home/add_board/components/add_board_filters/presentation/add_board_filters.dart';

Future<dynamic> showAddBoard(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    useSafeArea: true,
    isDismissible: false,
    enableDrag: false,
    isScrollControlled: true,
    builder: (_) {
      return const AddBoard();
    },
  );
}

class AddBoard extends StatelessWidget {
  const AddBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddBoardFiltersCubit(),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          color: kColorSand,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopRow(context),
            const SizedBox(
              height: 8,
            ),
            const Text("Boards are used to collect posts that match filters."),
            const SizedBox(
              height: 24,
            ),
            _buildNameInput(context),
            const SizedBox(
              height: 24,
            ),
            _buildDescriptionInput(context),
            const SizedBox(
              height: 24,
            ),
            _buildFiltersSelection(context),
            const Spacer(),
            const CreateButton(),
          ],
        ),
      ),
    );
  }

  Column _buildFiltersSelection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Filters",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        const ModifyFiltersButton(),
      ],
    );
  }

  Column _buildDescriptionInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        const CustomDescriptionInput(),
      ],
    );
  }

  Column _buildNameInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Name",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        const CustomInput(),
      ],
    );
  }

  Row _buildTopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "New Board",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        CustomIconButton(
          icon: kIconClose,
          click: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class ModifyFiltersButton extends StatelessWidget {
  const ModifyFiltersButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAddBoardFilters(context);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: kColorDeepBlood,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.string(
              kIconEdit,
              width: 24,
              height: 24,
              theme: SvgTheme(
                currentColor: kColorSand,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "Modify",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: kColorSand,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateButton extends StatelessWidget {
  const CreateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kColorRoyal,
      ),
      child: Center(
        child: Text(
          "Create",
          style: TextStyle(
            color: kColorSand,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        hintText: "Enter a name...",
        hintStyle: TextStyle(
          color: kColorRoyal.shade300,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        isDense: true,
        fillColor: kColorInput,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: kColorRoyal,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class CustomDescriptionInput extends StatelessWidget {
  const CustomDescriptionInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 3,
      maxLines: 5,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        hintText: "Enter a description...",
        hintStyle: TextStyle(
          color: kColorRoyal.shade300,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        isDense: true,
        fillColor: kColorInput,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: kColorRoyal,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
