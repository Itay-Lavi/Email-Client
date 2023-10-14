// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

import '../../../../models/mail.dart';

class MailViewDetail extends StatefulWidget {
  final MailModel mail;

  const MailViewDetail(this.mail, {super.key});

  @override
  State<MailViewDetail> createState() => _MailViewDetailState();
}

class _MailViewDetailState extends State<MailViewDetail> {
  WebViewXController? webviewController;

  @override
  Widget build(BuildContext context) {
    if (webviewController != null) {
      webviewController!.loadContent(widget.mail.html ?? '', SourceType.HTML);
    }

    return LayoutBuilder(
      builder: (context, constraints) => WebViewX(
        initialContent: widget.mail.html ?? '',
        initialSourceType: SourceType.HTML,
        onWebViewCreated: (controller) => webviewController = controller,
        width: constraints.maxWidth,
      ),
    );
  }
}
