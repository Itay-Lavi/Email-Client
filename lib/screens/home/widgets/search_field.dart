import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/mail/list/provider.dart';
import '../../../providers/mail/mail_ui.dart';

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
      context.read<MailListProvider>().getEmailsByText(text);
    }

    final color = inAppBar ? Theme.of(context).colorScheme.background : null;

    final showFilteredMails =
        context.select<MailUIProvider, bool>((prov) => prov.showFilteredMails);

    return TextField(
      focusNode: focusNode,
      cursorColor: color,
      style: TextStyle(fontSize: 16, color: color),
      controller: searchFieldController,
      textInputAction: TextInputAction.search,
      onSubmitted: (_) {
        searchEmailsByText();
      },
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
                        .read<MailUIProvider>()
                        .controlShowFilteredMails(false);
                  }),
          ],
        ),
      ),
    );
  }
}
