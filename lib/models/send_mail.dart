import 'dart:convert';

class MailDataModel {
  String from;
  List<String> to;
  String subject;
  String html;

  MailDataModel({
    required this.from,
    required this.to,
    required this.subject,
    required this.html,
  });

  MailDataModel copyWith({
    String? from,
    List<String>? to,
    String? subject,
    String? html,
  }) {
    return MailDataModel(
      from: from ?? this.from,
      to: to ?? this.to,
      subject: subject ?? this.subject,
      html: html ?? this.html,
    );
  }

  bool validate() {
    bool isEmailValid(String email) {
      if (email.isEmpty) return false;
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
      return emailRegex.hasMatch(email);
    }

    if (to.isEmpty) return false;

    if (to.every((email) => !isEmailValid(email))) {
      return false;
    }

    return true;
  }

  String toToText() {
    return to.join('; ');
  }

  static List<String> toToList(String text) {
    return text.split(';').map((e) => e.trim()).toList();
  }

  @override
  String toString() {
    return 'MailDataModel(from: $from, to: $to, subject: $subject, html: $html)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'from': from,
      'to': to,
      'subject': subject,
      'html': html,
    };
  }

  String toJson() => json.encode(toMap());
}
