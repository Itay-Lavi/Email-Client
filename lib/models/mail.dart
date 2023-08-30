import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../config/global_var.dart';

class MailModel with ChangeNotifier {
  String? id;
  Map<String, dynamic>? from;
  Map<String, dynamic>? to;
  String? subject;
  DateTime timestamp;
  List<String> flags = [];
  List<dynamic>? attachments;
  String? html;
  MailModel({
    this.id,
    required this.from,
    required this.to,
    required this.subject,
    required this.timestamp,
    required this.flags,
    this.attachments,
    this.html,
  });

  bool get isSeen =>
      flags.any((flag) => flag.toLowerCase().contains(globalflags[1]));

  bool get isFlagged =>
      flags.any((flag) => flag.toLowerCase().contains(globalflags[0]));

  void updateFlags(List<String> newFlags, bool addFlags) {
    if (addFlags) {
      flags.addAll(newFlags);
    } else {
      flags.removeWhere((flag) => newFlags.contains(flag.toLowerCase()));
    }
    notifyListeners();
  }

  static bool areListsEqual(List<MailModel> original, List<MailModel> fetched) {
    return listEquals(original, fetched);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'from': from,
      'to': to,
      'subject': subject,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'flags': flags,
      'attachments': attachments,
      'html': html,
    };
  }

  factory MailModel.fromMap(Map<String, dynamic> map) {
    return MailModel(
      id: map['id'] != null ? map['id'] as String : null,
      from: map['from'] != null
          ? Map<String, dynamic>.from((map['from'] as Map<String, dynamic>))
          : null,
      to: map['to'] != null
          ? Map<String, dynamic>.from((map['to'] as Map<String, dynamic>))
          : null,
      subject: map['subject'] as String,
      timestamp: DateTime.parse(map['timestamp']),
      flags: List<String>.from(map['flags']),
      html: map['html'] != null ? map['html'] as String : null,
      attachments: map['attachments'] != null
          ? List<dynamic>.from((map['attachments'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());
}
