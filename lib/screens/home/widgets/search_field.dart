import 'package:email_client/providers/mail/list/filtered.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/flushbar.dart';

class SearchField extends StatelessWidget {
  final bool inAppBar;
  final TextEditingController searchFieldController;
  final FocusNode? focusNode;

  const SearchField(
      {super.key,
      this.inAppBar = false,
      required this.searchFieldController,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    void searchEmailsByText() {
      final text = searchFieldController.text.trim();
      if (text.isEmpty) return;

      context
          .read<FilteredMailListProvider>()
          .getFilteredEmails(text)
          .onError((error, stackTrace) {
        showFlushBar(
            context, 'Error', 'An error occurred please try later', Colors.red);
      });
    }

    final color = inAppBar ? Theme.of(context).colorScheme.background : null;

    final showFilteredMails = context.select<FilteredMailListProvider, bool>(
        (prov) => prov.showFilteredMails);

    return TextField(
      focusNode: focusNode,
      cursorColor: color,
      style: TextStyle(fontSize: 16, color: color),
      controller: searchFieldController,
      textInputAction: TextInputAction.search,
      onSubmitted: (_) => searchEmailsByText(),
      decoration: InputDecoration(
        hintStyle: TextStyle(color: color),
        suffixIconColor: color,
        border: inAppBar
            ? const UnderlineInputBorder()
            : const OutlineInputBorder(),
        hintText: 'Search',
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                icon: const Icon(Icons.search), onPressed: searchEmailsByText),
            if (showFilteredMails)
              IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    searchFieldController.text = '';
                    context
                        .read<FilteredMailListProvider>()
                        .controlShowFilteredMails(false);
                  }),
          ],
        ),
      ),
    );
  }
}
