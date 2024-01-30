import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_second/uihelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: ForgetPasswordScreen(),));

}

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController= TextEditingController();

/*
  final auth=FirebaseAuth.instance;
*/

  void forgetpassword(String email)async{
    if(email==""){
       UiHelper.CustomAlertDialog(context, "Enter an Email To reset Password");
    }
    else{
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextFormField(emailController, "Email", Icons.mail, false),
          SizedBox(height: 20,),
          UiHelper.CustomButton(() {
            //FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.toString());
            forgetpassword(emailController.text.toString());
          }, "Reset Password")
        ],
      ),
    );
  }
}
