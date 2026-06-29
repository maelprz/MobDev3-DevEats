import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../home/home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await context.read<AuthViewModel>().login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst("Exception: ", ""),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                color: const Color(0xFF8DD3F3),

                child: const Center(
                  child: Text(
                    "DevEats",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24),

                child: Card(
                  elevation: 3,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(24),

                    child: Form(
                      key: _formKey,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const Text(
                            "Welcome",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            "Sign in to satisfy your cravings!",
                          ),

                          const SizedBox(height: 30),

                          const Text("EMAIL ADDRESS"),

                          const SizedBox(height: 8),

                          TextFormField(
                            controller: _emailController,

                            keyboardType:
                                TextInputType.emailAddress,

                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty) {
                                return "Please enter your email.";
                              }

                              if (!value.contains("@")) {
                                return "Invalid email.";
                              }

                              return null;
                            },

                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.email_outlined),

                              filled: true,
                              fillColor: Colors.grey.shade200,

                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          const Text("PASSWORD"),

                          const SizedBox(height: 8),

                          TextFormField(
                            controller: _passwordController,

                            obscureText: _obscurePassword,

                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty) {
                                return "Please enter your password.";
                              }

                              return null;
                            },

                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.lock_outline),

                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),

                                onPressed: () {
                                  setState(() {
                                    _obscurePassword =
                                        !_obscurePassword;
                                  });
                                },
                              ),

                              filled: true,
                              fillColor: Colors.grey.shade200,

                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          SizedBox(
                            width: double.infinity,
                            height: 55,

                            child: ElevatedButton(
                              onPressed: authViewModel.isLoading
                                  ? null
                                  : _login,

                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF8DD3F3),

                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(30),
                                ),
                              ),

                              child: authViewModel.isLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child:
                                          CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      "Sign In →",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [
                  const Text(
                    "Don't have an account? ",
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const RegisterScreen(),
                        ),
                      );
                    },

                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}