import 'package:flutter/material.dart';

class BottomListviewModal extends StatelessWidget {
  const BottomListviewModal({
    super.key,
    required this.newEmailsIsLoading,
  });

  final bool newEmailsIsLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: newEmailsIsLoading ? 70 : 0,
        child: newEmailsIsLoading
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16.0),
                  Text('Loading...')
                ],
              )
            : const SizedBox(),
      ),
    );
  }
}
