import '../config/config.dart';
import '../models/mail_account.dart';
import '../util/http.dart';

class AccountApiService {
  final MailAccountModel account;
  Map<String, String> headers = {};

  AccountApiService({required this.account});

  static Future<List<String>> fetchSupportedHosts() async {
    final url = Uri.http(hostname, '/auth/hosts');
    final body = await httpRequest(url, {}, HttpMethod.get);
    final decodedBody = body['response'] as List<dynamic>;
    final List<String> response =
        decodedBody.map((host) => host.toString()).toList();
    return response;
  }

  Future<dynamic> signIn() async {
    headers = {
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
      'Authorization': account.jwt!,
    };
    final url = Uri.http(hostname, '/auth');
    final body = await httpRequest(url, headers, HttpMethod.get);
    final accountResponse = body['response'] as Map<String, dynamic>;
    return accountResponse['email'] == account.email;
  }
}
