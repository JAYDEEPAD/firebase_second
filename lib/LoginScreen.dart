import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_second/SignUpScreen.dart';
import 'package:firebase_second/forgetpassword.dart';
import 'package:firebase_second/main.dart';
import 'package:firebase_second/uihelper.dart';
import 'package:flutter/material.dart';




void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: LoginScreen()));
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  void login(String email, String pass) async {
    if(email=="" && pass==""){
      UiHelper.CustomAlertDialog(context, "Enter Required Field");
    }
    else{
      FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass).then(
              (value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "My Home Page"))));
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
      ),
      body: ListView(
        children:[ Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              UiHelper.CustomTextFormField(emailController, "Email", Icons.mail, false),
              UiHelper.CustomTextFormField(passwordController, "Password", Icons.password, true),
              SizedBox(height: 30,),
              UiHelper.CustomButton(() {
                login(emailController.text.toString(), passwordController.text.toString());
              }, "Login"),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Alerady Have a account?",style: TextStyle(fontSize: 16),),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                  }, child: Text("SignUp", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),))
                ],
              ),
            SizedBox(height: 15,),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordScreen()));
            }, child: Text("Forget Password??",style: TextStyle(fontSize: 20,),))

          ],
        ),
      ],
      ),
    );
  }
}
