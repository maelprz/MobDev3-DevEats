import 'package:flutter/material.dart';
import '../../services/supabase_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String status = "Testing connection...";

  @override
  void initState() {
    super.initState();
    testConnection();
  }

  Future<void> testConnection() async {
    try {
      final response =
          await SupabaseService.client.from('food_items').select();

      setState(() {
        status = "✅ Connected!\nFound ${response.length} food item(s).";
      });
    } catch (e) {
      setState(() {
        status = "❌ Connection Failed\n\n$e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DevEats"),
      ),
      body: Center(
        child: Text(
          status,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}