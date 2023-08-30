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
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 212, 234, 252),
              Colors.white,
              Color.fromARGB(255, 255, 238, 213)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ),
          const Align(alignment: Alignment.center, child: AuthForm())
        ],
      ),
    );
  }
}
