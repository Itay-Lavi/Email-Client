import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';

import '../../../../providers/mail/mail_ui.dart';
import 'header/header.dart';

class MailEditor extends StatelessWidget {
  const MailEditor({super.key});

  @override
  Widget build(BuildContext context) {
    final mailData = context.read<MailUIProvider>().mailData;

    return Column(
      children: [
        MailEditorHeader(mailData),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) => HtmlEditor(
              htmlToolbarOptions: const HtmlToolbarOptions(
                  textStyle: TextStyle(color: Colors.black),
                  toolbarType: ToolbarType.nativeGrid),
              controller: HtmlEditorController(),
              callbacks: Callbacks(
                  onChangeContent: (value) => context
                      .read<MailUIProvider>()
                      .updateMailData(updates: {'html': value ?? ''})),
              htmlEditorOptions: HtmlEditorOptions(initialText: mailData.html),
              otherOptions: OtherOptions(height: constraints.maxHeight),
            ),
          ),
        ),
      ],
    );
  }
}
