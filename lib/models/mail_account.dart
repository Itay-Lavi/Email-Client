import 'package:flutter/material.dart';

class MailAccountModel with ChangeNotifier {
  final String host;
  final String email;
  final String? jwt;
  final String? password;
  int? unseenCount;

  MailAccountModel({
    required this.host,
    required this.email,
    this.jwt,
    this.password,
    this.unseenCount,
  });

  void setUnseenCount(int count) {
    unseenCount = count;
    notifyListeners();
  }

  // void updateSpecialUseAttribTypes(List<MailFolderModel>? folders) {
  //   if (folders == null) return;

  //   for (final folder in folders) {
  //     // Check if the folder's name matches any of the specialUseAttribTypes keys
  //     if (specialUseAttribTypes.containsKey(folder.specialUseAttrib)) {
  //       // Update the value for the matching key with the folder's value
  //       specialUseAttribTypes[folder.specialUseAttrib!] = 'folder.callname';
  //     }
  //   }
  // }
}
