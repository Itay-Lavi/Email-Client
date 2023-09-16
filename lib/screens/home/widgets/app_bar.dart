import 'dart:async';

import 'package:email_client/models/mail.dart';
import 'package:email_client/providers/mail/mail_ui.dart';
import 'package:email_client/screens/home/mail/view/header/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../providers/mail/list/provider.dart';
import '../../../providers/mail/mail_folder.dart';
import 'search_field.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  Timer? _timer;
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();
  bool _searchIsActive = false;

  _changeSearchStatus() {
    setState(() {
      _searchIsActive = !_searchIsActive;
    });
    if (_searchIsActive) {
      _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        _onFocusChange();
      });
    }
    if (!_searchIsActive && _timer != null) _timer!.cancel();
  }

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_searchFocusNode.hasFocus &&
        _searchIsActive &&
        _searchController.text.isEmpty) {
      _changeSearchStatus();
    }
  }

  void setupSystemUIOverlay(BuildContext context, Color primaryColor) {
    final mySystemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: const Color.fromARGB(255, 8, 53, 91),
      statusBarBrightness: Brightness.dark,
      statusBarColor: primaryColor,
    );
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
  }

  @override
  Widget build(BuildContext context) {
    final primayColor = Theme.of(context).colorScheme.primary;

    setupSystemUIOverlay(context, primayColor);

    final mailListProvider = context.read<MailListProvider>();
    final mailEditorIsOpen =
        context.select<MailUIProvider, bool>((prov) => prov.mailEditorIsOpen);
    final selectedMail = context
        .select<MailListProvider, MailModel?>((prov) => prov.selectedMail);
    final mailIsSelected = selectedMail != null;

    final mailboxName = context.select<MailFolderProvider, String>(
        (prov) => prov.currentFolder?.name ?? 'inbox');

    return AppBar(
      title: (!mailIsSelected && !_searchIsActive && !mailEditorIsOpen)
          ? Text(mailboxName)
          : mailEditorIsOpen
              ? const Text('New Message')
              : null,
      leading: mailIsSelected || mailEditorIsOpen
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => mailEditorIsOpen
                  ? context.read<MailUIProvider>().controlMailEditor()
                  : mailListProvider.selectCurrentEmail(null))
          : null,
      actions: [
        if (mailEditorIsOpen)
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => mailListProvider.sendEmail(context),
          ),
        if (mailIsSelected && !mailEditorIsOpen)
          ChangeNotifierProvider.value(
              value: selectedMail, child: const MailHeaderActions()),
        if (!mailIsSelected && !_searchIsActive && !mailEditorIsOpen)
          IconButton(
              icon: const Icon(Icons.search), onPressed: _changeSearchStatus),
        if (!mailIsSelected && !mailEditorIsOpen && _searchIsActive)
          SizedBox(
              width: 270,
              child: SearchField(
                inAppBar: true,
                searchFieldController: _searchController,
                focusNode: _searchFocusNode,
              ))
      ],
    );
  }
}
