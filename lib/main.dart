import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:isolates/person.dart';

import 'one_direction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  int _runningFunction(int arg) {
    int sum = 0;
    for (int i = 1; i <= arg; i++) {
      sleep(Duration(seconds: 1));
      print(i);
      sum += i;
    }
    return sum;
  }

  void _incrementCounter() async {
    await fetchUser();

    //========
    setState(() {
      _counter++;
    });
  }
  Future<int> pauseFunction() async {
    return _runningFunction(10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:FutureBuilder(
        future: compute(_runningFunction,2),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              '${snapshot.data}',
              style: Theme.of(context).textTheme.headline4,
            );
          }
          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
