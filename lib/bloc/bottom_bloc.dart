import 'package:flutter_block_1/bloc/app_bloc.dart';

class BottomBloc extends AppBloc{
  BottomBloc({
    Duration? waitBeforeLoading,
    required Iterable<String> urls,
  }) : super (
    waitBeforeLoading: waitBeforeLoading,
    urls: urls,
  );
}
