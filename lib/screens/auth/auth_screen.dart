import 'package:flutter/material.dart';

import 'form/form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              const Color.fromARGB(255, 212, 234, 252),
              Theme.of(context).colorScheme.background,
              const Color.fromARGB(255, 255, 238, 213)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ),
          const Align(alignment: Alignment.center, child: AuthForm())
        ],
      ),
    );
  }
}
