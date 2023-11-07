import 'package:chat_massanger_app/firebase_options.dart';
import 'package:chat_massanger_app/pages/regist_page.dart';
import 'package:chat_massanger_app/services/auth/auth_gate.dart';
import 'package:chat_massanger_app/services/auth/auth_service.dart';
import 'package:chat_massanger_app/services/auth/loginOrRegister.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/loginPage.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  // runApp(const MyApp());
  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(), 
    child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home:RegisterPage()
      // home:LoginPage()
      home:AuthGate()
      
    );
  }
}
