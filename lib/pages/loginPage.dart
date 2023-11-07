import 'package:chat_massanger_app/component/my_button.dart';
import 'package:chat_massanger_app/component/my_text_field.dart';
import 'package:chat_massanger_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // signIN
  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    // Check if email and password are not empty
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email dan password tidak boleh kosong")));
      return;
    }

    try {
      await authService.signInWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  // logo
                  const Icon(Icons.message_outlined,
                      size: 100, color: Color.fromARGB(255, 45, 30, 28)),

                  // walcome back message
                  const SizedBox(height: 50),
                  const Text(
                    "selamat datang \n kami merindukanmu",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 50),
                  // email textfield
                  MyTextField(
                      controller: emailController,
                      hintText: "email",
                      obscureText: false),

                  const SizedBox(height: 25),
                  // password textfield
                  MyTextField(
                      controller: passwordController,
                      hintText: "password",
                      obscureText: true),
                  const SizedBox(height: 25),

                  // sign button
                  MyButton(onTap: signIn, text: "sign in"),
                  SizedBox(height: 15),

                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Bukan anggota?"),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "daftar sekarang",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 15)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
