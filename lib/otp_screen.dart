import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_second/main.dart';
import 'package:flutter/material.dart';

/*void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OTPScreen(
        verificationid: '',
      )));
}*/

class OTPScreen extends StatefulWidget {
  String verificationid;
  OTPScreen({super.key, required this.verificationid});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController _OtpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Screen"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: TextFormField(
                controller: _OtpController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintText: "Enter OTP",
                    suffixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ))),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                PhoneAuthCredential creditial =
                await PhoneAuthProvider.credential(
                    verificationId: widget.verificationid,
                    smsCode: _OtpController.text.toString());
                FirebaseAuth.instance.signInWithCredential(creditial).then(
                        (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyHomePage(title: "My HomePage"))));
              },
              child: Text("OTP")),
        ],
      ),
    );
  }
}
