import 'package:evenmt_sportif/presentation/pages/AllCategoty.dart';
import 'package:evenmt_sportif/presentation/pages/AllEvent.dart';
import 'package:evenmt_sportif/presentation/pages/AllEventPopular.dart';
import 'package:evenmt_sportif/presentation/pages/LoginPage.dart';
import 'package:evenmt_sportif/firebase_options.dart';
import 'package:evenmt_sportif/presentation/pages/RegisterPage.dart';
import 'package:evenmt_sportif/presentation/widget/NavBarButtom.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,      
      initialRoute: "login",
       routes: {
        "login": (context) =>  LoginPage(),
        "register" :(context) =>  RegisterPage(),
        "home" :(context) =>const NavBarButton(),
         "category": (context) => const AllCategory(),
        "eventpopular" :(context) =>const  AllEventPopular(),
        "event" :(context) =>const  AllEvent(),

       },
    );
  }
}
