// ignore_for_file: public_member_api_docs, sort_constructors_first

class AccountDbModel {
  String email;
  String jwt;
  String host;
  int unseenCount;

  AccountDbModel({
    required this.email,
    required this.jwt,
    required this.host,
    required this.unseenCount,
  });
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'jwt': jwt,
      'host': host,
      'unseen_count': unseenCount,
    };
  }
}

class FolderDbModel {
  String name;
  String accountEmail;
  int favorite;
  int? unseenCount;
  String? specialUseAttrib;
  String? childrenJson;

  FolderDbModel(
      {required this.name,
      required this.accountEmail,
      required this.favorite,
      this.unseenCount,
      this.specialUseAttrib,
      this.childrenJson});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'account_email': accountEmail,
      'favorite': favorite,
      'unseen_count': unseenCount,
      'special_use_attrib': specialUseAttrib,
      'children_json': childrenJson,
    };
  }
}

class MailDbModel {
  int id;
  String accountEmail;
  String folderName;
  String from;
  String to;
  String subject;
  String timestamp;
  String flags;
  String html;

  MailDbModel({
    required this.id,
    required this.accountEmail,
    required this.folderName,
    required this.from,
    required this.to,
    required this.subject,
    required this.timestamp,
    required this.flags,
    required this.html,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'account_email': accountEmail,
      'folder_name': folderName,
      'from_map': from,
      'to_map': to,
      'subject': subject,
      'timestamp': timestamp,
      'flags': flags,
      'html': html,
    };
  }
}
