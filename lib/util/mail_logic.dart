import 'package:intl/intl.dart';

import '../models/mail.dart';

String? getFromAddress(MailModel mail) {
  final fromAddress = mail.from?['value']?.isNotEmpty == true
      ? mail.from!['value'][0]['address']
      : 'none';
  return fromAddress;
}

String? getFromName(MailModel mail) {
  return mail.from!['value'][0]['name'];
}

List<String> getAddressList(Map<String, dynamic>? to) {
  final addressArr = to?['value'] as List<dynamic>?;

  return addressArr
          ?.map((value) => value['address'] as String? ?? '')
          .toList() ??
      [];
}

Map<String, List<MailModel>> groupAndSortEmails(List<MailModel> mails) {
  Map<String, List<MailModel>> groupedEmails = {};
  if (mails.isEmpty) {
    return groupedEmails;
  }

  mails.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  for (MailModel mail in mails) {
    String day = DateFormat('dd/MM/yyyy').format(mail.timestamp);
    if (groupedEmails.containsKey(day)) {
      groupedEmails[day]!.add(mail);
    } else {
      groupedEmails[day] = [mail];
    }
  }

  return groupedEmails;
}
