import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';

import 'config/supabase_config.dart';
import 'views/auth/login_screen.dart';
import 'views/home/home_screen.dart';
import 'viewmodels/auth_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  runApp(const DevEatsApp());
}

class DevEatsApp extends StatelessWidget {
  const DevEatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "DevEats",
        theme: ThemeData(
          fontFamily: 'Roboto',
        ),
        home: const LoginScreen(),
      ),
    );
  }
}