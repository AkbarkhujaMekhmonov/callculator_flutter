import 'dart:ui';

import 'package:callculator_app/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String expression = "";
  String result = "0";
  double fontSize = 40;

  void _addCharacter(String character) {
    setState(() {
      expression += character;
      if (!"+-*/".contains(character)) {
        _updateResult();
      }
    });
  }

  void _updateResult() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression.replaceAll('x', '*'));
      ContextModel cm = ContextModel();
      result = "${exp.evaluate(EvaluationType.REAL, cm)}";
    } catch (e) {
      result = "NuN";
    }
    _updateFontSize();
  }
  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        expression = "";
        result = "0";
        fontSize = 24.0;
      } else if (buttonText == "=") {
        _updateResult();
        expression = result;
      } else if(buttonText=="%"){
        modifyLastNumber(expression);
        _updateResult();

      }else {
        _addCharacter(buttonText);
      }
    });
  }

  void _updateFontSize() {
    setState(() {
      int lines = '\n'.allMatches(expression).length + 1;
      if (lines > 2) {
        return;
      } else if (expression.length > 13) {
        fontSize = 25.0;
      } else {
        fontSize = 40;
      }
    });
  }
  String modifyLastNumber(String text) {
    // Matndan probellarni va bo'shliqlarni olib tashlash
    String trimmedText = text.trim();

    // Matndan oxirgi sonni topish
    RegExp lastNumberRegex = RegExp(r'\b(\d+(\.\d+)?)\b$');
    Match? match = lastNumberRegex.firstMatch(trimmedText);

    if (match != null) {
      // Oxirgi sonni raqamga o'tkazish
      String lastNumberString = match.group(0)!;
      double lastNumber = double.parse(lastNumberString);

      // 1 foizini qo'shish
      double modifiedNumber = lastNumber * 1.01;

      // O'zgartirilgan sonni matnga qaytarish
      String modifiedText = trimmedText.replaceFirst(lastNumberString, modifiedNumber.toString());

      return modifiedText;
    }

    // Agar matnda raqam bo'lmasa, o'zgartirilmagan matnni qaytarish
    return text;
  }
  void _addBrackets() {
    setState(() {
      if (expression.isEmpty || '+-*/('.contains(expression[expression.length - 1])) {
        expression += '(';
      } else {
        int openBrackets = expression.split('(').length - 1;
        int closeBrackets = expression.split(')').length - 1;

        if (openBrackets > closeBrackets && expression[expression.length - 1] != '(') {
          expression += ')';
        } else {
          expression += '*(';
        }
      }

      // Check if all parentheses are balanced
      bool allParenthesesBalanced = _checkParenthesesBalance();
      if (allParenthesesBalanced) {
        _updateResult();
      }
    });
  }

  bool _checkParenthesesBalance() {
    int openBrackets = 0;
    int closeBrackets = 0;

    for (int i = 0; i < expression.length; i++) {
      if (expression[i] == '(') {
        openBrackets++;
      } else if (expression[i] == ')') {
        closeBrackets++;
      }

      if (closeBrackets > openBrackets) {
        return false; // More close parentheses than open parentheses
      }
    }

    return openBrackets == closeBrackets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 1, left: 1, right: 1),
                  height: 200,
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Container(
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        expression,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.only(bottom: 10.0,right: 20.0,left: 20.0,top: 10.0),
                  child: Text(
                    result,
                    style: const TextStyle(fontSize: 20.0,color: Colors.grey),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.only(right: 30),
                  child: GestureDetector(
                    child: Icon(Icons.backspace,color: Colors.green,size: 30,),
                  ),
                ),
                Container(height: 1,margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),color: Color(0xFFEEEEEE),)
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: 500,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Button(
                        title: "C",
                        titleColor: Colors.red,
                        onTap: () {
                          buttonPressed("C");
                          _updateFontSize();
                        },
                      ),
                      Button(
                        title: "()",
                        titleColor: Colors.green,
                        onTap: () {
                          _addBrackets();
                          _updateFontSize();
                        },
                      ),
                      Button(
                        title: "%",
                        titleColor: Colors.green,
                        onTap: () {
                          buttonPressed("%");
                          _updateFontSize();
                        },
                      ),
                      Button(
                        title: "/",
                        titleColor: Colors.green,
                        onTap: () {
                          buttonPressed("/");
                          _updateFontSize();

                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Button(
                        title: "7",
                        onTap: () {
                          _updateFontSize();
                          buttonPressed("7");
                        },
                      ),
                      Button(
                        title: "8",
                        onTap: () {
                          buttonPressed("8");
                          _updateFontSize();

                        },
                      ),
                      Button(
                        title: "9",
                        onTap: () {
                          buttonPressed("9");
                          _updateFontSize();

                        },
                      ),
                      Button(
                        title: "x",
                        titleColor: Colors.green,
                        onTap: () {
                          buttonPressed("*");
                          _updateFontSize();

                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Button(
                        title: "4",
                        onTap: () {
                          _updateFontSize();

                          buttonPressed("4");
                        },
                      ),
                      Button(
                        title: "5",
                        onTap: () {
                          _updateFontSize();

                          buttonPressed("5");
                        },
                      ),
                      Button(
                        title: "6",
                        onTap: () {
                          _updateFontSize();

                          buttonPressed("6");
                        },
                      ),
                      Button(
                        title: "-",
                        titleColor: Colors.green,
                        onTap: () {
                          _updateFontSize();

                          buttonPressed("-");
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Button(
                        title: "1",
                        onTap: () {
                          _updateFontSize();

                          buttonPressed("1");
                        },
                      ),
                      Button(
                        title: "2",
                        onTap: () {
                          _updateFontSize();

                          buttonPressed("2");
                        },
                      ),
                      Button(
                        title: "3",
                        onTap: () {
                          _updateFontSize();

                          buttonPressed("3");
                        },
                      ),
                      Button(
                        title: "+",
                        titleColor: Colors.green,
                        onTap: () {
                          _updateFontSize();

                          buttonPressed("+");
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Button(
                        title: "+/-",
                        onTap: () {
                          buttonPressed("+/-");
                        },
                      ),
                      Button(
                        title: "0",
                        onTap: () {
                          _updateFontSize();

                          buttonPressed("0");
                        },
                      ),
                      Button(
                        title: ".",
                        onTap: () {
                          _updateFontSize();

                          buttonPressed(".");
                        },
                      ),
                      Button(
                        title: "=",
                        titleColor: Colors.white,
                        color: Colors.green,
                        onTap: () {
                          _updateFontSize();

                          buttonPressed("=");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
