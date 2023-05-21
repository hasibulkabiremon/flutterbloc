import 'package:flutter/material.dart';
import 'package:flutter_block_1/bloc/app_bloc.dart';
import 'package:flutter_block_1/bloc/app_state.dart';
import 'package:flutter_block_1/bloc/bloc_event.dart';
import 'package:flutter_block_1/extentions/stream/start_with.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocView<T extends AppBloc> extends StatelessWidget {
  const AppBlocView({Key? key}) : super(key: key);

  void startUpdatingBloc(BuildContext context) {
    Stream.periodic(
      const Duration(seconds: 10),
      (_) => const LoadNextUrlEvent(),
    ).startWith(const LoadNextUrlEvent()).forEach((event) {
      context.read<T>().add(
            event,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    startUpdatingBloc(context);
    return Expanded(
      child: BlocBuilder<T, AppState>(
        builder: (context, appState) {
          if (appState.error != null) {
            return const Text('An error ocurred. Try again in a moment!');
          } else if (appState.data != null) {
            return Image.memory(
              appState.data!,
              fit: BoxFit.fitHeight,
            );
          }else{
            return const Center(child:
              CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
