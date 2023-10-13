import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'config/theme.dart';
import './screens/auth/auth_screen.dart';
import './screens/home/home_screen.dart';
import 'providers/providers.dart';
import 'providers/settings_provider.dart';
import 'screens/settings_screen.dart';

void main() async {
  //setUrlStrategy(PathUrlStrategy());
  await dotenv.load(fileName: "api.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: providers, child: const App());
  }
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool darkMode =
        context.select<SettingsProvider, bool>((prov) => prov.darkMode);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Email Client',
        themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
        theme: lightTheme(context),
        darkTheme: darkTheme(context),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          AuthScreen.routeName: (context) => const AuthScreen(),
          SettingsScreen.routeName: (context) => const SettingsScreen()
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute<void>(
              settings: settings,
              builder: (BuildContext context) => const HomeScreen());
        });
  }
}
