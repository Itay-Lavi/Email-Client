import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/mail_account.dart';
import '../../../providers/mail/accounts.dart';
import '../validator.dart';
import './drop_down_btn.dart';
import './form.dart';

class FormInputs extends StatefulWidget {
  const FormInputs({
    super.key,
    required this.addMailAccount,
  });

  final Future<void> Function(MailAccountModel mailAccount) addMailAccount;

  @override
  State<FormInputs> createState() => _FormInputsState();
}

class _FormInputsState extends State<FormInputs> {
  String _host = defaultHost;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late Future<List<String>> _supportedHostFuture;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _supportedHostFuture =
        context.read<MailAccountsProvider>().getSupportedHosts();
  }

  void setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  void addAccount() async {
    final validation = _formKey.currentState!.validate();
    if (!validation) return;

    final mailAccount = MailAccountModel(
        host: _host,
        email: _emailController.text,
        password: _passwordController.text);
    setLoading(true);
    await widget.addMailAccount(mailAccount);
    setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _supportedHostFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final hosts = snapshot.data ?? [];

        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  validator: emailValidator,
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: passwordValidator,
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                FormDropDownBtn(hosts, (val) => _host = val),
                const SizedBox(height: 40),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator()),
                if (!_isLoading)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ElevatedButton(
                      onPressed: addAccount,
                      child: const Text('Add Account'),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
