import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';

import '../../../../models/send_mail.dart';
import '../../../../providers/mail/mail_ui.dart';

class MailHtmlEditor extends StatelessWidget {
  const MailHtmlEditor({super.key});

  @override
  Widget build(BuildContext context) {
    final mailData =
        context.select<MailUIProvider, MailDataModel>((prov) => prov.mailData);

    return LayoutBuilder(
      builder: (context, constraints) => HtmlEditor(
        htmlToolbarOptions: const HtmlToolbarOptions(
            textStyle: TextStyle(color: Colors.black),
            toolbarType: ToolbarType.nativeGrid),
        controller: HtmlEditorController(),
        callbacks:
            Callbacks(onChangeContent: (value) => mailData.html = value ?? ''),
        htmlEditorOptions: HtmlEditorOptions(initialText: mailData.html),
        otherOptions: OtherOptions(height: constraints.maxHeight),
      ),
    );
  }
}
