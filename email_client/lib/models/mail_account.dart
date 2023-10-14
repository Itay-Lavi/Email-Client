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
}
