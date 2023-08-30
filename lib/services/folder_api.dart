import 'package:email_client/models/mail_folder.dart';

import '../config/global_var.dart';
import '../models/mail_account.dart';
import '../util/http.dart';

class FolderApiService {
  final MailAccountModel account;
  final MailFolderModel? folderModel;
  Map<String, String> headers = {};

  FolderApiService({required this.account, this.folderModel}) {
    headers = {
      'Authorization': account.jwt!,
    };
  }

  Future<List<dynamic>> getFolders() async {
    final url = Uri.http(hostname, '/folder');
    final body = await httpRequest(url, headers, HttpMethod.get);

    return body['response'] as List<dynamic>;
  }
}
