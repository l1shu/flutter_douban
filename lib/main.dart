import 'package:flutter/material.dart';
import './routes/Home.dart';
import './routes/Citys.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // initialRoute: '/',
      routes: {
        // '/': (context) => MyHomePage(),
        '/Citys': (context) => Citys()
      },
      home: MyHomePage(),
    );
  }
}