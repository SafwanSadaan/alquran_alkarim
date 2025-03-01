import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/cache_helper.dart';
import 'core/helper_methods.dart';
import 'provider/theme_provider.dart';
import 'core/constant/constants.dart';
import 'views/widget/splash/view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool themeBool = prefs.getBool("isDark") ?? false;
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(isDark: themeBool),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await readJson();
      await getSettings();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<ThemeProvider>(
        builder: ((context, value, child) {
          return MaterialApp(
            title: 'القرآن الكريم',
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            theme: value.getTheme,
            home: const SplashView(),
          );
        }),
      ),
    );
  }
}
