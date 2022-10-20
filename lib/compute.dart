//One of the easiest is to use the compute function. This will execute our code in a different isolate
// and return the results to our main isolate.
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:isolates/person.dart';

Future<Person> fetchUser() async {
  final userData = json.encode({'name': 'mohamad'});
  return await compute(deserializePerson, userData,debugLabel: 'mohamad');
}

Person deserializePerson(String data) {
  Map<String, dynamic> dataMap = json.decode(data);
  return Person(name: dataMap["name"]);
}
