import 'dart:convert';
import 'dart:isolate';

import 'package:isolates/person.dart';

Future<Person> fetchUser() async {
  /// use receivePort to receive data from isolate and handle send port to isolate to send data to me
  ReceivePort port = ReceivePort();
  final userData = json.encode({'name': 'mohamad', 'favourite': 'black'});
  final isolate = await Isolate.spawn<List<dynamic>>(
      deserializePersonOneDirection, [port.sendPort, userData]);
  final person = await port.first;
  isolate.kill(priority: Isolate.immediate);
  return person;
}

void deserializePersonOneDirection(List<dynamic> values) {
  /// handle sendPort from parent to return data to him after processing
  SendPort sendPort = values[0];
  String data = values[1];

  Map<String, dynamic> dataMap = json.decode(data);
  sendPort.send(Person(name: dataMap["name"]));
}
