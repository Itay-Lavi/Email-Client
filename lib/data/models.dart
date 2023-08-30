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
  factory AccountDbModel.fromMap(Map<String, dynamic> map) {
    return AccountDbModel(
      email: map['email'] as String,
      jwt: map['jwt'] as String,
      host: map['host'] as String,
      unseenCount: map['unseen_count'] as int,
    );
  }

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
  int? id;
  String name;
  String accountEmail;
  int favorite;
  int? unseenCount;
  String? specialUseAttrib;
  int? parentId;

  FolderDbModel(
      {this.id,
      required this.name,
      required this.accountEmail,
      required this.favorite,
      this.unseenCount,
      this.specialUseAttrib,
      this.parentId});

  factory FolderDbModel.fromMap(Map<String, dynamic> map) {
    return FolderDbModel(
      id: map['id'],
      name: map['name'] as String,
      accountEmail: map['account_email'] as String,
      favorite: map['favorite'] as int,
      unseenCount:
          map['unseen_count'] != null ? map['unseen_count'] as int : null,
      specialUseAttrib: map['special_use_attrib'] != null
          ? map['special_use_attrib'] as String
          : null,
      parentId: map['parent_id'] != null ? map['parent_id'] as int : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'account_email': accountEmail,
      'favorite': favorite,
      'unseen_count': unseenCount,
      'special_use_attrib': specialUseAttrib,
      'parent_id': parentId,
    };
  }
}

class MailDbModel {
  String id;
  String accountEmail;
  int folderId;
  String from;
  String? to;
  String? subject;
  String? html;
  String? flags;
  String timestamp;

  MailDbModel({
    required this.id,
    required this.accountEmail,
    required this.folderId,
    required this.from,
    required this.to,
    required this.subject,
    required this.timestamp,
    required this.flags,
    required this.html,
  });

  factory MailDbModel.fromMap(Map<String, dynamic> map) {
    return MailDbModel(
      id: map['id'] as String,
      accountEmail: map['account_email'] as String,
      folderId: map['folder_id'] as int,
      from: map['from_map'] as String,
      to: map['to_map'] as String?,
      subject: map['subject'] as String,
      timestamp: map['timestamp'] as String,
      html: map['html'] as String,
      flags: map['flags'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'account_email': accountEmail,
      'folder_id': folderId,
      'from_map': from,
      'to_map': to,
      'subject': subject,
      'timestamp': timestamp,
      'flags': flags,
      'html': html,
    };
  }
}
