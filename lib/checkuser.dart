
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_second/LoginScreen.dart';
import 'package:firebase_second/main.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: CheckUser(),));
}

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null ? MyHomePage(title: "Home Page") : LoginScreen();
  }

}
