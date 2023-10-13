part of 'provider.dart';

mixin MailListProviderState {
  List<MailModel>? _mails;
  List<MailModel>? get mails => _mails != null ? [..._mails!] : null;

  MailModel? _selectedMail;
  MailModel? get selectedMail => _selectedMail;

  MailDatabase? _mailDb;
  MailDatabase? get mailDb => _mailDb;
}
