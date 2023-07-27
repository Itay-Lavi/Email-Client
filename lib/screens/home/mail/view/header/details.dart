import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../models/mail.dart';

class HeaderMailDetails extends StatelessWidget {
  final MailModel mail;
  const HeaderMailDetails(this.mail, {super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.black);

    String dateAndTime =
        '${DateFormat.yMd().format(mail.timestamp)}  ${DateFormat.Hm().format(mail.timestamp)}';

    String fromAddress = '';
    try {
      fromAddress = mail.from?['value'][0]['address'];
    } catch (_) {}

    List<String> toAddress = [];
    try {
      final addressArr = mail.to?['value'] as List<dynamic>;
      toAddress =
          addressArr.map((value) => value['address'] as String? ?? '').toList();
    } catch (_) {}

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                child: Text(
                  fromAddress[0] + fromAddress[1],
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      fromAddress,
                      style: textStyle.copyWith(fontSize: 18),
                      maxLines: 1,
                    ),
                  ),
                  Text(
                    dateAndTime,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 100, 100, 100)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'To: ${toAddress.join('; ')}',
            style: textStyle,
          )
        ],
      ),
    );
  }
}
