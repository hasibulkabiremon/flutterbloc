import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_block_1/bloc/person.dart';

const person1Url = 'http://127.0.0.1:5500/api/person1.json';
const person2Url = 'http://127.0.0.1:5500/api/person2.json';

typedef PersonsLoader = Future<Iterable<Person>> Function(String url);

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonsAction implements LoadAction {
  final String url;
  final PersonsLoader loader;
  const LoadPersonsAction({required this.url, required this.loader}) : super();
}
