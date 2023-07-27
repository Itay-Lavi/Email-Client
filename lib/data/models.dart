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
  String callname;
  bool favorite;

  FolderDbModel({
    required this.name,
    required this.accountEmail,
    required this.callname,
    required this.favorite,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'account_email': accountEmail,
      'callname': callname,
      'favorite': favorite ? 1 : 0,
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
  bool seen;
  String html;

  MailDbModel({
    required this.id,
    required this.accountEmail,
    required this.folderName,
    required this.from,
    required this.to,
    required this.subject,
    required this.timestamp,
    required this.seen,
    required this.html,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'account_email': accountEmail,
      'folder_name': folderName,
      'from': from,
      'to': to,
      'subject': subject,
      'timestamp': timestamp,
      'seen': seen ? 1 : 0,
      'html': html,
    };
  }
}
