import 'package:flutter/material.dart';


class UiHelper{
  static CustomTextFormField(TextEditingController controller, String text, IconData iconData, bool toHide ){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
      child: TextFormField(
        controller: controller,
        obscureText: toHide,
        decoration: InputDecoration(
          hintText: text,
          suffixIcon: Icon(iconData),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25)
          )
        ),

      ),
    );
  }

  static CustomButton(VoidCallback voidCallback, String text){
    return SizedBox(height: 50,width: 300,child: ElevatedButton(onPressed: (){
      voidCallback ();
    },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),  child: Text(text,style: TextStyle(color: Colors.white,fontSize: 20))),);
  }

  static CustomAlertDialog(BuildContext context, String text){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(text),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("OK"))
        ],
      );
    });
  }
}