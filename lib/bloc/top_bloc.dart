import 'package:flutter_block_1/bloc/app_bloc.dart';

class TopBloc extends AppBloc{
  TopBloc({
    Duration? waitBeforeLoading,
    required Iterable<String> urls,
}) : super (
    waitBeforeLoading: waitBeforeLoading,
    urls: urls,
  );
}