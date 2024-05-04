import 'package:chatsphere/config/firebase_config.dart';
import 'package:chatsphere/config/themes/theme.dart';
import 'package:chatsphere/presentation/helpers/auth_gate.dart';
import 'package:flutter/material.dart';

void main() async {
  await setup();
  runApp(const MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
  await registerService();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatSphere',
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      home: const SafeArea(
        child: AuthGate()
      ),
    );
  }
}
