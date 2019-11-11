import 'package:flutter/material.dart';
import 'package:todo_project/comp/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/':(context)=>HomePage(),
        },
      );
  }
}
