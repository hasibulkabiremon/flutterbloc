import 'package:bloc/bloc.dart';
import 'package:flutter_block_1/apis/login_api.dart';
import 'package:flutter_block_1/bloc/actions.dart';
import 'package:flutter_block_1/bloc/app_state.dart';
import 'package:flutter_block_1/models.dart';

import '../apis/notes_api.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocall loginApi;
  final NotesApiProtocall notesApi;

  AppBloc({
    required this.loginApi,
    required this.notesApi,
  }) : super(const AppState.empty()) {
    on<LoginAction>((event, emit) async {
      // stat loading
      emit(
        const AppState(
          isLoading: true,
          loginError: null,
          loginHandle: null,
          fetchedNotes: null,
        ),
      );

      // log the user
      final loginHandle = await loginApi.login(
        email: event.email,
        password: event.password,
      );
      emit(
        AppState(
          isLoading: false,
          loginError: loginHandle == null ? LoginErrors.invalidHandle : null,
          loginHandle: loginHandle,
          fetchedNotes: null,
        ),
      );
    });
    on<LoadNotesAction>((event, emit) async {
      // Start Loadding
      emit(
        AppState(
          isLoading: true,
          loginError: null,
          loginHandle: state.loginHandle,
          fetchedNotes: null,
        ),
      );

      // get the login handle

      final loginHandle = state.loginHandle;
      if (loginHandle != const LoginHandle.foobar()) {
        // invalid login handle cannot fetch notes
        emit(
          AppState(
            isLoading: false,
            loginError: LoginErrors.invalidHandle,
            loginHandle: loginHandle,
            fetchedNotes: null,
          ),
        );
        return;
      } else {
        //we have valid login handle and fetch notes

        final notes = await notesApi.getNotes(loginHandle: loginHandle!);
        emit(
          AppState(
            isLoading: false,
            loginError: null,
            loginHandle: loginHandle,
            fetchedNotes: notes,
          ),
        );
      }
    });
  }
}
