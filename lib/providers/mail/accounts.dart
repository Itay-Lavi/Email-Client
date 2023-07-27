import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:email_client/providers/ui_provider.dart';
import 'package:email_client/services/account_api.dart';

import '../../models/mail_account.dart';

class MailAccountsProvider extends ChangeNotifier {
  final BuildContext _context;
  final List<MailAccountModel> _mailAccounts = [];
  List<MailAccountModel> get mailAccounts => [..._mailAccounts];

  MailAccountModel? currentAccount;

  MailAccountsProvider(this._context) {
    initilizeAccounts();
  }

  void setCurrentAccount(MailAccountModel account) {
    if (currentAccount != account) {
      currentAccount = account;
      notifyListeners();
    }
  }

  setAccountUnseenCount(int totalCount) {
    currentAccount?.setUnseenCount(totalCount);
  }

  Future<List<String>> getSupportedHosts() async {
    List<String> hosts = ['gmail', 'outlook'];
    try {
      hosts = await AccountApi.fetchSupportedHosts();
    } catch (_) {}
    return hosts;
  }

  Future<void> addMailAccount(MailAccountModel account) async {
    // try {
    final token = await AccountApi(account).generateJwt();
    final newAccount =
        MailAccountModel(host: account.host, email: account.email, jwt: token);

    _mailAccounts.add(newAccount);
    setCurrentAccount(newAccount);
    notifyListeners();
    // } catch (e) {
    //   print(e);
    // }
  }

  void removeMailAccount() {
    // _mailAccounts.remove(account);
    notifyListeners();
  }

  void initilizeAccounts() async {
    WidgetsFlutterBinding.ensureInitialized();

    //setCurrentAccount(_mailAccounts[0]);
    _context.read<UIProvider>().controlIsLoading(false);
  }
}

      // final isValidated = await AccountApi(newAccount).validateJwt();
      // if (!isValidated) {
      //   throw UnsupportedError('Something went wrong when adding account!');
      // }