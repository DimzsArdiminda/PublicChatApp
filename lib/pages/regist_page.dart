import 'package:chat_massanger_app/component/my_button.dart';
import 'package:chat_massanger_app/component/my_text_field.dart';
import 'package:chat_massanger_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // signUP
  void signUP() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("password not equals")));
      return;
    }
    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailandPassword(
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
                    "Silahkan buat akun mu!",
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

                  // confirm password textfield
                  MyTextField(
                      controller: confirmPasswordController,
                      hintText: "confirm password",
                      obscureText: true),
                  const SizedBox(height: 25),

                  // sign button
                  MyButton(onTap: signUP, text: "daftar"),

                  const SizedBox(height: 25),
                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("SIAP MENJADI ANGGOTA?"),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "login sekarang",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
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
