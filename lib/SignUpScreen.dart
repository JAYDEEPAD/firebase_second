import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_second/LoginScreen.dart';
import 'package:firebase_second/main.dart';
import 'package:firebase_second/uihelper.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: SignUpScreen(),));
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  void signUpScreen(String email, String pass) async {
    if(email=="" && pass==""){
      UiHelper.CustomAlertDialog(context, "Enter Required Field");
    }
    else{
      UserCredential?  userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass).then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
        log("User Created");
      }
      );
    }
        // userCredential;
     /*await FirebaseAuth.instance.createUserWithEmailAndPassword(email: "abc@gmail.com", password: "123456").catchError((e)=>print(e));
     // FirebaseFirestore.instance.collection("user").add({"name":"hello"}).catchError((e)=>print(e));*/
      //print(userCredential);
      /*try{
        UserCredential? userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString()).then((value){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: '')));
        });
      }*/
      /*on FirebaseAuthException catch(ex){
          return UiHelper.CustomAlertDialog(context, ex.code.toString());
      }
*/



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextFormField(emailController, 'Email', Icons.mail, false),
          UiHelper.CustomTextFormField(passwordController, 'Password', Icons.password, true),
          SizedBox(height: 30,),
          UiHelper.CustomButton(() {
          signUpScreen(emailController.text.toString(), passwordController.text.toString());
          }, "SignUp")
        ],
      ),
    );
  }
}
