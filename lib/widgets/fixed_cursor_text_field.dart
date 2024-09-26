// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class FixedCursorTextField extends StatefulWidget {
//   @override
//   _FixedCursorTextFieldState createState() => _FixedCursorTextFieldState();
// }
//
// class _FixedCursorTextFieldState extends State<FixedCursorTextField> {
//   String _cursorText = "";
//
//   _FixedCursorTextFieldState
//
//   (
//
//   String cursorText
//   ){
//     this._cursorText=cursorText;
//   }
//
//   final TextEditingController _controller = TextEditingController();
//   final FocusNode _focusNode = FocusNode();
//
//   @override
//   void initState() {
//   super.initState();
//   // Listen to text changes and move the cursor to the end
//   _controller.addListener(() {
//   _focusNode.requestFocus();
//   _controller.selection = TextSelection.fromPosition(
//   TextPosition(offset: _controller.text.length),
//   );
//   });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//     controller: _controller,
//     focusNode: _focusNode,
//     textDirection: TextDirection.rtl,
//     textAlign: TextAlign.right,
//     showCursor: true,
//     readOnly: true,
//     style: TextStyle(fontSize: 30,color: Colors.black),
//     decoration: InputDecoration(
//     hintText: 'Type here...',
//     ),
//     inputFormatters: <TextInputFormatter>[
//     // Preventing cursor movement by restricting input changes
//     FilteringTextInputFormatter.allow(RegExp(r'.*')),
//     ],
//     );
//   }
// }