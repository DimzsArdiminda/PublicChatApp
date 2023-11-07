import 'package:chat_massanger_app/pages/loginPage.dart';
import 'package:chat_massanger_app/pages/regist_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // initial login show
  bool showLoginPage = true;

  // toggle between login and register
  void tooglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: tooglePages);
    }else{
      return RegisterPage(onTap: tooglePages);
    }
  }
}
