// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class MailFolderModel with ChangeNotifier {
  final String name;
  String? callName;
  bool favorite;
  int? unseenCount;
  int? totalCount;
  final List<MailFolderModel>? children;

  MailFolderModel({
    required this.name,
    this.callName,
    this.favorite = true,
    this.unseenCount,
    this.totalCount,
    required this.children,
  });

  setUnseenCount(int count) {
    unseenCount = count;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'callName': callName,
      'favorite': favorite,
      'unseenCount': unseenCount,
      'totalCount': totalCount,
      'children': children,
    };
  }

  factory MailFolderModel.fromMap(Map<String, dynamic> map) {
    List<dynamic>? childrenData = map['children'];

    List<MailFolderModel>? childrenList;
    if (childrenData != null) {
      childrenList =
          childrenData.map((child) => MailFolderModel.fromMap(child)).toList();
    }

    return MailFolderModel(
      name: map['name'],
      favorite: false,
      children: childrenList,
    );
  }

  String toJson() => json.encode(toMap());
}
