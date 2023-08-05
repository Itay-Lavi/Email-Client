import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MailFolderModel extends Equatable with ChangeNotifier {
  final String name;
  bool favorite;
  String? callname;
  String? specialUseAttrib;
  int? unseenCount;
  final List<MailFolderModel>? children;

  MailFolderModel({
    required this.name,
    required this.children,
    this.favorite = false,
    this.callname,
    this.specialUseAttrib,
    this.unseenCount,
  });

  @override
  List<Object> get props => [name, favorite];

  static bool areListsEqual(
      List<MailFolderModel> list1, List<MailFolderModel> list2) {
    if (list1.length != list2.length) {
      return false;
    }

    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }

    return true;
  }

  // Recursive function to find a folder by specialUseAttrib in a list of folders
  static MailFolderModel? findFolderBySpecialUseAttribInList(
      List<MailFolderModel>? folders, String specialUseAttrib) {
    if (folders == null) return null;

    for (final folder in folders) {
      if (folder.specialUseAttrib == specialUseAttrib) {
        return folder;
      }

      final result =
          findFolderBySpecialUseAttribInList(folder.children, specialUseAttrib);
      if (result != null) {
        return result;
      }
    }

    return null;
  }

  setUnseenCount(int count) {
    unseenCount = count;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'favorite': favorite,
      'unseenCount': unseenCount,
      'callname': callname,
      'children': children,
      'specialUseAttrib': specialUseAttrib
    };
  }

  factory MailFolderModel.fromMap(Map<String, dynamic> map,
      [String? parentName]) {
    List<dynamic>? childrenData = map['children'];

    List<MailFolderModel>? childrenList;
    if (childrenData != null) {
      childrenList = childrenData
          .map((child) => MailFolderModel.fromMap(child, map['name']))
          .toList();
    }

    final callname =
        parentName != null ? '$parentName/${map['name']}' : map['name'];

    return MailFolderModel(
      name: map['name'],
      favorite: map['favorite'] == 1,
      callname: callname,
      specialUseAttrib: map['specialUseAttrib'],
      unseenCount: map['unseenCount'] ?? 0,
      children: childrenList,
    );
  }

  String toJson() => json.encode(toMap());
}
