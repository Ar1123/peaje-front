import 'package:flutter/material.dart';
import 'package:peaje/config/shared/preferences.dart';

import 'Pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences().initPref();
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Peaje',
      debugShowCheckedModeBanner: false,
      home: IndexPage(),
    );
  }
}
