import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';

  // Array of button labels
  final List<String> buttons = [
    'C', 'CE', '+/-', '%',
    '7', '8', '9', '/',
    '4', '5', '6', 'x',
    '1', '2', '3', '-',
    '0', '.', '=', '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Calculator"),
        centerTitle: true,
        backgroundColor: Colors.teal[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade900, Colors.teal.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (buttons[index] == 'C') {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput = '';
                          answer = '';
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.redAccent,
                      textColor: Colors.white,
                      withShadow: true,
                    );
                  } else if (buttons[index] == 'CE') {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          answer = '';
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.orangeAccent,
                      textColor: Colors.white,
                      withShadow: true,
                    );
                  } else if (buttons[index] == '=') {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.greenAccent.shade700,
                      textColor: Colors.white,
                      withShadow: true,
                    );
                  } else {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Colors.teal.shade300
                          : Colors.white,
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.black,
                      withShadow: isOperator(buttons[index]),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Designed by Aliyu Haruna Kofarsoro u2/22/csc/0995",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    return x == '/' || x == 'x' || x == '-' || x == '+' || x == '=';
  }

  // Function to calculate the input operation
  void equalPressed() {
    String finalUserInput = userInput.replaceAll('x', '*');

    try {
      Parser p = Parser();
      Expression exp = p.parse(finalUserInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        answer = eval.toString();
      });
    } catch (e) {
      setState(() {
        answer = 'Error';
      });
    }
  }
}
