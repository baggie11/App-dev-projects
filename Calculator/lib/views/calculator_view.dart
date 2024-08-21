import 'dart:math';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../calculate_button.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    // Check if the result contains a decimal
    String doesContainDecimal(dynamic result) {
      if (result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if (!(int.parse(splitDecimal[1]) > 0)) {
          return result = splitDecimal[0].toString();
        }
      }
      return result;
    }

    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "+/-") {
        if (equation[0] != '-') {
          equation = '-$equation';
        } else {
          equation = equation.substring(1);
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '%');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          result = doesContainDecimal(result);
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black54,
        leading: const Icon(Icons.settings, color: Colors.green),
        actions: const [
          Padding(
            padding: EdgeInsets.only(top: 18.0),
            child: Text('DEG', style: TextStyle(color: Colors.white38)),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            result,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 80,
                            ),
                          ),
                        ),
                        const Icon(Icons.more_vert, color: Colors.green, size: 30),
                        const SizedBox(width: 20),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            equation,
                            style: const TextStyle(
                              fontSize: 40,
                              color: Colors.white38,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            buttonPressed("⌫");
                          },
                          icon: const Icon(Icons.backspace_outlined,
                              color: Colors.green, size: 30),
                        )
                      ],
                    ),
                    const SizedBox(width: 20)
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculate_button('AC', Colors.white10, () => buttonPressed('AC')),
                calculate_button('%', Colors.white10, () => buttonPressed('%')),
                calculate_button('÷', Colors.white10, () => buttonPressed('÷')),
                calculate_button("×", Colors.white10, () => buttonPressed('×')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculate_button('7', Colors.white24, () => buttonPressed('7')),
                calculate_button('8', Colors.white24, () => buttonPressed('8')),
                calculate_button('9', Colors.white24, () => buttonPressed('9')),
                calculate_button('-', Colors.white10, () => buttonPressed('-')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculate_button('4', Colors.white24, () => buttonPressed('4')),
                calculate_button('5', Colors.white24, () => buttonPressed('5')),
                calculate_button('6', Colors.white24, () => buttonPressed('6')),
                calculate_button('+', Colors.white10, () => buttonPressed('+')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        calculate_button('1', Colors.white24, () => buttonPressed('1')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.07
                        ),
                        calculate_button('2', Colors.white24, () => buttonPressed('2')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04
                        ),
                        calculate_button('3', Colors.white24, () => buttonPressed('3')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.002
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        calculate_button('+/-', Colors.white24, () => buttonPressed('+/-')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.07
                        ),
                        calculate_button('0', Colors.white24, () => buttonPressed('0')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04
                        ),
                        calculate_button('.', Colors.white24, () => buttonPressed('.')),
                      ],
                    )
                  ],
                ),
                calculate_button("=", Colors.green, () => buttonPressed("=")),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
