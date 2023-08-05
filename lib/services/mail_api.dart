// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:email_client/models/mail_account.dart';
import 'package:email_client/models/send_mail.dart';
import 'package:email_client/util/http.dart';

import '../config/global_var.dart';

class MailApi {
  final MailAccountModel account;
  final MailDataModel? emailData;
  final String? folderName;
  final String? fetchSlice;
  Map<String, String> headers = {};

  MailApi({
    required this.account,
    this.emailData,
    this.folderName,
    this.fetchSlice,
  }) {
    if (account.jwt == null) {
      throw ArgumentError('JWT token cannot be null.');
    }
    headers = {
      'Content-Type': 'application/json',
      'Authorization': account.jwt!,
    };
  }

  Future<Map<String, dynamic>> getMails() async {
    final queryParams = {'fetchSlice': fetchSlice, 'mailBoxName': folderName};
    final url =
        Uri.http(hostname, '/mail').replace(queryParameters: queryParams);

    return await httpRequest(url, headers, HttpMethod.get);
  }

  Future<void> sendMail() async {
    final url = Uri.http(hostname, '/mail');
    await httpRequest(url, headers, HttpMethod.post, emailData!.toJson());
  }

  Future<void> flagMail(
      String mailId, List<String> flags, bool addFlags) async {
    final body = {'flags': flags, 'addFlags': addFlags};
    final url = Uri.http(hostname, '/mail/flag/$mailId');
    await httpRequest(url, headers, HttpMethod.patch, jsonEncode(body));
  }

  Future<void> moveMailFolder(String mailId, String folderCallname) async {
    final body = {'folder': folderCallname};
    final url = Uri.http(hostname, '/mail/move/$mailId');
    await httpRequest(url, headers, HttpMethod.put, jsonEncode(body));
  }

  Future<List<dynamic>> getFolders() async {
    final url = Uri.http(hostname, '/folder');

    final body = await httpRequest(url, headers, HttpMethod.get);

    return body['response'] as List<dynamic>;
  }
}
