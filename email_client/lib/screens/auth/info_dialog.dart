import 'package:email_client/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  Expanded(
                    child: Wrap(
                      children: [
                        logoIconBtn(Assets.icons.platforms.googleIcon,
                            'https://myaccount.google.com/apppasswords'),
                        logoIconBtn(Assets.icons.platforms.outlookIcon,
                            'https://account.live.com/proofs/AppPassword'),
                        logoIconBtn(Assets.icons.platforms.yahooIcon,
                            'https://login.yahoo.com/myaccount/security/app-password'),
                        logoIconBtn(Assets.icons.platforms.appleIcon,
                            'https://appleid.apple.com/account/manage'),
                      ],
                    ),
                  ),
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

IconButton logoIconBtn(AssetGenImage asset, String url) {
  return IconButton(
      onPressed: () async {
        final Uri uri = Uri.parse(url);
        launchUrl(uri);
      },
      icon: asset.image(width: 30, height: 30));
}
