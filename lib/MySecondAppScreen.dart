import 'package:flutter/material.dart';
import 'MySecondaryHomePage.dart';

class MySecondAppScreen extends StatelessWidget {
  const MySecondAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MySecondaryHomePage(title: 'Flutter Demo!'),
    );
  }
}
