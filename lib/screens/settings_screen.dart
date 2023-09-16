import 'package:email_client/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: SettingsList(),
      ),
    );
  }
}

class SettingsList extends StatelessWidget {
  const SettingsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: const Text(
            'Dark Mode',
          ),
          trailing: Consumer<UIProvider>(
            builder: (context, prov, __) => Switch(
              value: prov.darkMode,
              onChanged: prov.controlTheme,
            ),
          ),
        ),
      ],
    );
  }
}
