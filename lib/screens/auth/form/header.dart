import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final bool canPop;

  const FormHeader(this.canPop, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/logo.png',
            width: 100,
            height: 100,
            alignment: Alignment.center,
          ),
        ),
        if (canPop)
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
          ),
      ],
    );
  }
}
