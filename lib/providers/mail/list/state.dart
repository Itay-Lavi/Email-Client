part of 'provider.dart';

mixin MailListProviderState {
  List<MailModel>? _mails;
  List<MailModel>? get mails => _mails != null ? [..._mails!] : null;

  List<MailModel>? _filteredMails;
  List<MailModel>? get filteredMails =>
      _filteredMails != null ? [..._filteredMails!] : null;

  MailModel? _selectedMail;
  MailModel? get selectedMail => _selectedMail;

  MailDatabase? _mailDb;
}
