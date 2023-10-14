// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:email_client/models/mail_account.dart';
import 'package:email_client/models/send_mail.dart';
import 'package:email_client/util/http.dart';

class MailApiService {
  final MailAccountModel account;
  final MailDataModel? emailData;
  final String? folderName;
  final String? fetchSlice;
  Map<String, String> headers = {};

  MailApiService({
    required this.account,
    this.emailData,
    this.folderName,
    this.fetchSlice,
  }) {
    if (account.jwt == null) {
      throw ArgumentError('JWT token cannot be null.');
    }
    headers = {
      'Authorization': account.jwt!,
    };
  }

  Future<Map<String, dynamic>> getMails() async {
    final queryParams = {'fetchSlice': fetchSlice, 'mailbox': folderName};
    final url = parseUrl('/mail').replace(queryParameters: queryParams);

    final response = await httpRequest(url, headers, HttpMethod.get);

    return response;
  }

  Future<Map<String, dynamic>> getMailsByText(String text) async {
    final queryParams = {'mailbox': folderName, 'filter': text};
    final url = parseUrl('/mail/filter').replace(queryParameters: queryParams);

    return await httpRequest(url, headers, HttpMethod.get);
  }

  Future<void> sendMail() async {
    final url = parseUrl('/mail');
    await httpRequest(url, headers, HttpMethod.post, emailData!.toJson());
  }

  Future<void> flagMail(
      String mailId, List<String> flags, bool addFlags) async {
    final body = {'flags': flags, 'addFlags': addFlags};
    final url = parseUrl('/mail/flag/$mailId');
    await httpRequest(url, headers, HttpMethod.patch, jsonEncode(body));
  }

  Future<void> moveMailFolder(String mailId, String folderCallname) async {
    final body = {'folder': folderCallname};
    final url = parseUrl('/mail/move/$mailId');
    await httpRequest(url, headers, HttpMethod.put, jsonEncode(body));
  }
}
