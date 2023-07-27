import 'package:email_client/models/mail_account.dart';
import 'package:email_client/util/http.dart';

import '../config/global_var.dart';

class AccountApi {
  final MailAccountModel account;
  Map<String, String> headers = {};

  AccountApi(this.account);

  static Future<List<String>> fetchSupportedHosts() async {
    final url = Uri.http(hostname, '/auth/hosts');
    final body = await httpRequest(
        url, {'Content-Type': 'application/json'}, HttpMethod.get);
    final decodedBody = body['response'] as List<dynamic>;
    final List<String> response =
        decodedBody.map((host) => host.toString()).toList();
    return response;
  }

  Future<dynamic> generateJwt() async {
    if (account.password == null) {
      throw ArgumentError('password cannot be null.');
    }
    headers = {
      'Content-Type': 'application/json',
      'email': account.email,
      'password': account.password!,
      'hosting': account.host
    };

    final url = Uri.http(hostname, '/auth');
    final body = await httpRequest(url, headers, HttpMethod.post);
    return body['response'] as dynamic;
  }

  Future<bool> validateJwt() async {
    if (account.jwt == null) {
      throw ArgumentError('jwt connot be null.');
    }
    headers = {
      'Content-Type': 'application/json',
      'Authorization': account.jwt!,
    };
    final url = Uri.http(hostname, '/auth');
    final body = await httpRequest(url, headers, HttpMethod.get);
    final accountResponse = body['response'] as Map<String, dynamic>;
    return accountResponse['email'] == account.email;
  }
}
