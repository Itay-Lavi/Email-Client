import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MailModel {
  String? id;
  Map<String, dynamic>? from;
  Map<String, dynamic>? to;
  String? subject;
  DateTime timestamp;
  bool seen;
  List<dynamic>? attachments;
  String? html;
  MailModel({
    this.id,
    required this.from,
    required this.to,
    required this.subject,
    required this.timestamp,
    required this.seen,
    this.attachments,
    this.html,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'from': from,
      'to': to,
      'subject': subject,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'seen': seen,
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
      seen: map['seen'] as bool,
      attachments: map['attachments'] != null
          ? List<dynamic>.from((map['attachments'] as List<dynamic>))
          : null,
      html: map['html'] != null ? map['html'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());
}
