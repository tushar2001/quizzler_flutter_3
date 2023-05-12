import 'dart:ffi';

import 'package:flutter/material.dart';
import 'QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'MySecondAppScreen.dart';
import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

void main() => runApp(Quizzler());

@pragma('vm:entry-point')
void secondary() => runApp(const MySecondAppScreen());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  _QuizPageState() {
    _channel.setMethodCallHandler(_handleMessage);
  }
  final _channel = const MethodChannel('com.quizzler');

  int _count = 0;

  void increment() {
    _channel.invokeMethod<Void>('incrementScore');
  }

  Future<dynamic> _handleMessage(MethodCall call) async {
    if (call.method == 'reportScore') {
      _count = call.arguments as int;
      // notifyListeners();
    }
  }

  List<Icon> scoreKeeper = [];

  Icon checkIcon = Icon(
    Icons.check,
    color: Colors.green,
  );

  Icon closeIcon = Icon(
    Icons.close,
    color: Colors.red,
  );

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();

    setState(() {
      if (quizBrain.isFinished()) {
        // Alert(
        //   title: 'Finished',
        //   desc: 'You\'ve have reached the end of the quiz',
        //   context: context,
        // ).show();

        Alert(
          context: context,
          type: AlertType.error,
          title: "RFLUTTER ALERT",
          desc: "Flutter is more awesome with RFlutter Alert.",
          buttons: [
            DialogButton(
              child: Text(
                "COOL",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();

        quizBrain.reset();
        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          increment();
          scoreKeeper.add(checkIcon);
        } else {
          scoreKeeper.add(closeIcon);
        }
        quizBrain.nextQuestion();
      }
    });
  }

  QuizBrain quizBrain = QuizBrain();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              'Score: ${_count}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        )),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
