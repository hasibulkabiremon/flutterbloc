
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block_1/apis/login_api.dart';
import 'package:flutter_block_1/apis/notes_api.dart';
import 'package:flutter_block_1/bloc/actions.dart';
import 'package:flutter_block_1/bloc/app_bloc.dart';
import 'package:flutter_block_1/dialogs/generic_dialogs.dart';
import 'package:flutter_block_1/dialogs/loading_screen.dart';
import 'package:flutter_block_1/models.dart';
import 'package:flutter_block_1/strings.dart';
import 'package:flutter_block_1/views/iterable_list_view.dart';
import 'package:flutter_block_1/views/login_view.dart';

import 'bloc/app_state.dart';

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
      home: const Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(
        loginApi: LoginApi(),
        notesApi: NotesApi(),
      ),
      child: Scaffold(
          appBar: AppBar(
            title: const Text(homePage),
          ),
          body: BlocConsumer<AppBloc, AppState>(
            listener: (context, appState) {
              if (appState.isLoading) {
                LoadingScreen.instance().show(
                  context: context,
                  text: pleaseWait,
                );
              } else {
                LoadingScreen.instance().hide();
              }
              final loginError = appState.loginError;
              if (loginError != null) {
                showGenericDialog(
                  context: context,
                  title: loginErrorDialogTitle,
                  content: loginErrorDialogContent,
                  optionBuilder: () => {ok: true},
                );
              }
              // if we are logged in, but we have no fetched notes, fetch them now

              if (appState.isLoading == false &&
                  appState.loginError == null &&
                  appState.loginHandle == const LoginHandle.foobar() &&
                  appState.fetchedNotes == null) {
                context.read<AppBloc>().add(const LoadNotesAction());
              }
            },
            builder: (context, appState) {
              final notes = appState.fetchedNotes;
              if (notes == null) {
                return LoginView(
                  onLoginTapped: (email, password) {
                    context.read<AppBloc>().add(
                          LoginAction(
                            email: email,
                            password: password,
                          ),
                        );
                  },
                );
              } else {
                return notes.toListView();
              }
            },
          ),),
    );
  }
}
