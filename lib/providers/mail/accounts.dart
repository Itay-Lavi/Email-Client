import 'package:email_client/data/databases/account.dart';
import 'package:email_client/data/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:email_client/providers/ui_provider.dart';
import 'package:email_client/services/account_api.dart';

import '../../data/helper.dart';
import '../../models/mail_account.dart';

class MailAccountsProvider extends ChangeNotifier {
  final BuildContext _context;
  AccountDatabase? _accountDb;
  List<MailAccountModel> _mailAccounts = [];
  List<MailAccountModel> get mailAccounts => [..._mailAccounts];

  MailAccountModel? currentAccount;

  MailAccountsProvider(this._context) {
    void init() async {
      final db = await DatabaseHelper().database;
      _accountDb = AccountDatabase(db);
      initilizeAccounts();
    }

    init();
  }

  void setCurrentAccount(MailAccountModel account) {
    if (currentAccount == account) {
      return;
    }

    currentAccount = account;
    notifyListeners();
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
    try {
      final token = await AccountApi(account).signin();
      final newAccount = MailAccountModel(
          host: account.host, email: account.email, jwt: token);

      await _accountDb!.insertAccount(AccountDbModel(
          email: account.email,
          host: account.host,
          jwt: token,
          unseenCount: 0));

      _mailAccounts.add(newAccount);
      setCurrentAccount(newAccount);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void removeMailAccount(MailAccountModel account) async {
    try {
      await _accountDb!.deleteAccount(account.email);
    } catch (_) {}

    _mailAccounts.remove(account);
    notifyListeners();
  }

  void initilizeAccounts() async {
    WidgetsFlutterBinding.ensureInitialized();

    final allAccounts = await _accountDb!.getAllAccounts();
    if (allAccounts.isNotEmpty) {
      _mailAccounts = allAccounts;
      setCurrentAccount(_mailAccounts[0]);
    }
    // ignore: use_build_context_synchronously
    _context.read<UIProvider>().controlIsLoading(false);
  }
}
