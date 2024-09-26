import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Color? color;
  String title;
  Color titleColor;
  Function onTap;

   Button({super.key,this.color ,this.title="",this.titleColor=Colors.black, required this.onTap,});

  String textFieldEditor(String text){
    return text+title;
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        
        onTap: () {
          onTap();
        },
        child: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(7),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color??Color(0xFFEEEEEE)),
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 30,color: titleColor),
            ),
          ),
        ),
      ),
    );
  }
}
