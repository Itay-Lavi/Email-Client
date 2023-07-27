// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/mail/accounts.dart';
import 'drop_down_btn.dart';

const defaultHost = 'gmail';

class AuthForm extends StatelessWidget {
  const AuthForm(this.addMailAccount, {super.key});
  final void Function(
      {required String email,
      required String password,
      required String host}) addMailAccount;

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    String host = defaultHost;
    List<String> hosts = [];

    void setHost(String val) {
      host = val;
    }

    return Container(
        margin: const EdgeInsets.all(12),
        width: 400,
        child: Card(
          surfaceTintColor: const Color.fromARGB(255, 220, 239, 255),
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: FutureBuilder(
                future:
                    context.read<MailAccountsProvider>().getSupportedHosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  hosts = snapshot.data!;
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          '../../../assets/images/logo.png',
                          width: 100,
                          height: 100,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        FormDropDownBtn(hosts, setHost),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: ElevatedButton(
                            onPressed: () {
                              String email = emailController.text;
                              String password = passwordController.text;

                              addMailAccount(
                                  email: email, password: password, host: host);
                            },
                            child: const Text('Add Account'),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ));
  }
}
