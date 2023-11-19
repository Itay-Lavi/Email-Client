import 'package:email_client/gen/assets.gen.dart';
import 'package:flutter/material.dart';

Future<void> showInfoDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;

      return Dialog(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Important Information',
                  style: TextStyle(fontSize: 30)),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'You have to get app password first!\nPlease access your account settings.\nThen click on "Get App Password" button.',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(height: 1.3),
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (screenWidth > 400)
                    Assets.images.secureCloud.image(
                      height: 110,
                      width: 110,
                    )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
