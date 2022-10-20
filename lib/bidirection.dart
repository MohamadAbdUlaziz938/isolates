import 'dart:convert';
import 'dart:isolate';

import 'package:isolates/person.dart';

void deserializePerson(SendPort sendPort) {
  ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  receivePort.listen((message) {
    Map<String, dynamic> dataMap = jsonDecode(message);
    sendPort.send(Person(name: dataMap["name"]));
  });
}
