import 'package:flutter/material.dart';

class MySecondaryHomePage extends StatefulWidget {
  const MySecondaryHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MySecondaryHomePage> createState() => _MySecondaryHomePageState();
}

class _MySecondaryHomePageState extends State<MySecondaryHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'New layout screen!',
            ),
          ],
        ),
      ),
    );
  }
}
