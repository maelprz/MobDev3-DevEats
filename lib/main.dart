import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/supabase_config.dart';

import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/home_viewmodel.dart';

import 'views/auth/login_screen.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(),
        ),

        ChangeNotifierProvider(
          create: (_) => HomeViewModel(),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "DevEats",

        theme: ThemeData(
          fontFamily: "Roboto",
          useMaterial3: true,
        ),

        home: const LoginScreen(),
      ),
    );
  }
}