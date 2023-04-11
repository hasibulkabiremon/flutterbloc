import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc_action.dart';
import 'bloc/person.dart';
import 'bloc/persons_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(create: (_) => PersonBloc(), child: const Homepage()),
    );
  }
}

Future<Iterable<Person>> getPerson(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((req) => req.close())
    .then((resp) => resp.transform(utf8.decoder).join())
    .then((str) => json.decode(str) as List<dynamic>)
    .then((list) => list.map((e) => Person.fromJson(e)));

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    late final Bloc myBloc;
    return Scaffold(
      body: Column(children: [
        Row(
          children: [
            TextButton(
                onPressed: () {
                  context
                      .read<PersonBloc>()
                      .add(const LoadPersonsAction(url: person1Url, loader: getPerson));
                },
                child: Text('Load Json #1')),
            TextButton(
                onPressed: () {
                  context
                      .read<PersonBloc>()
                      .add(const LoadPersonsAction(url: person2Url, loader: getPerson));
                },
                child: Text('Load Json #2')),
          ],
        ),
        BlocBuilder<PersonBloc, FetchResult?>(
            buildWhen: (previousResult, currentResult) {
          return previousResult?.persons != currentResult?.persons;
        }, builder: ((context, state) {
          final persons = state?.persons;
          if (persons == null) {
            return const SizedBox();
          }
          return Expanded(
              child: ListView.builder(
                  itemCount: persons.length,
                  itemBuilder: (context, index) {
                    final person = persons[index]!;
                    return ListTile(
                      title: Text(person.name),
                      subtitle: Text(person.age.toString()),
                    );
                  }));
        }))
      ]),
    );
  }
}
