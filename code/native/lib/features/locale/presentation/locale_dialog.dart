import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/features/locale/application/locale_bloc/locale_bloc_bloc.dart';
import 'package:local/features/locale/domain/locale.dart';
import 'package:local/shared/application/app/app_bloc.dart';

class LocaleDialog extends StatefulWidget {
  const LocaleDialog({Key? key}) : super(key: key);

  @override
  State<LocaleDialog> createState() => _LocaleDialogState();
}

class _LocaleDialogState extends State<LocaleDialog> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(-1, 1),
                  blurRadius: 8,
                  color: Colors.black,
                ),
              ],
            ),
            child: Column(
              children: [
                // group 1: search bar
                _buildSearchBar(context),
                const Padding(
                  padding: EdgeInsets.all(8),
                ),
                // group 2: searches
                _buildLoadedSearches(context, state),
              ],
            ),
          ),
        );
      },
    );
  }

  Column _buildLoadedSearches(BuildContext context, LocaleState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // group 1: title
        _searchController.text == ""
            ? Column(
                children: [
                  Text(
                    "Recent",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                  ),
                ],
              )
            : Container(),
        // group 2: searches
        _buildLocales(state),
      ],
    );
  }

  ListView _buildLocales(LocaleState state) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: state.locales.length,
      separatorBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.all(8),
        );
      },
      itemBuilder: (context, index) {
        return LocaleListItem(
          locale: state.locales[index],
        );
      },
    );
  }

  Column _buildSearchBar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title
        Text(
          "Choose a Locale",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const Padding(
          padding: EdgeInsets.all(4),
        ),
        // search bar
        CupertinoSearchTextField(
          controller: _searchController,
          onChanged: (value) {
            if (value == "") {
              _searchController.clear();
              context.read<LocaleBloc>().add(LoadLocales());
            }
          },
          onSuffixTap: () {
            _searchController.clear();
            context.read<LocaleBloc>().add(LoadLocales());
          },
          onSubmitted: (value) {
            context.read<LocaleBloc>().add(SearchLocales(query: value));
          },
        ),
      ],
    );
  }
}

class LocaleListItem extends StatelessWidget {
  const LocaleListItem({
    Key? key,
    required this.locale,
  }) : super(key: key);

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AppBloc>().add(UpdateLocale(locale: locale));
      },
      child: Row(
        children: [
          // dot
          Container(
            decoration: BoxDecoration(
              color: Colors.green.shade200,
              borderRadius: BorderRadius.circular(100),
            ),
            width: 12,
            height: 12,
          ),
          const Padding(
            padding: EdgeInsets.all(4),
          ),
          // title
          Text(
            locale.displayName,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Spacer(),
          // state
          Text(locale.state),
        ],
      ),
    );
  }
}
