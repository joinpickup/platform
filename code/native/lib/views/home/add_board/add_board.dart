import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/icon_button.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';
import 'package:local/views/home/add_board/components/add_board_filters/add_board_filters.dart';
import 'package:local/views/home/add_board/components/visibility_selector/cubit/visibility_selector_cubit.dart';
import 'package:local/views/home/add_board/components/visibility_selector/presentation/visibility_selector.dart';

Future<dynamic> showAddBoard(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    useSafeArea: true,
    enableDrag: true,
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
    return BlocProvider(
      create: (context) => VisibilitySelectorCubit(),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          color: kColorSand,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopRow(context),
            const SizedBox(
              height: 24,
            ),
            _buildNameInput(),
            const SizedBox(
              height: 24,
            ),
            _buildDescriptionInput(),
            const SizedBox(
              height: 24,
            ),
            _buildVisibilitySelector(),
            const SizedBox(
              height: 24,
            ),
            _buildFiltersSelection(),
            const Spacer(),
            const CreateButton(),
          ],
        ),
      ),
    );
  }

  Column _buildFiltersSelection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Filter",
          style: TextStyle(
            color: kColorRoyal,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        ModifyFiltersButton(),
      ],
    );
  }

  Column _buildVisibilitySelector() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Visibility",
          style: TextStyle(
            color: kColorRoyal,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        VisibilitySelector(),
      ],
    );
  }

  Column _buildDescriptionInput() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: TextStyle(
            color: kColorRoyal,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        CustomDescriptionInput(),
      ],
    );
  }

  Column _buildNameInput() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Name",
          style: TextStyle(
            color: kColorRoyal,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        CustomInput(),
      ],
    );
  }

  Row _buildTopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "New Board",
          style: TextStyle(
            color: kColorRoyal,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
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
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
          border: Border.all(color: kColorRoyal, width: 2),
        ),
        child: const Center(
          child: Text(
            "Modify Filter",
            style: TextStyle(
              color: kColorRoyal,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
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
      child: const Center(
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
          color: Colors.grey.shade600,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        isDense: true,
        fillColor: kColorInput,
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50),
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
          color: Colors.grey.shade600,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        isDense: true,
        fillColor: kColorInput,
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(24),
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
