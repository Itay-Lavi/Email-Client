import '../config/config.dart';
import '../models/mail_account.dart';
import '../models/mail_folder.dart';
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
    final url = Uri.parse('$API_URL/folder');
    final body = await httpRequest(url, headers, HttpMethod.get);

    return body['response'] as List<dynamic>;
  }
}
