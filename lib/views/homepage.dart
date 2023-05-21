import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block_1/bloc/bottom_bloc.dart';
import 'package:flutter_block_1/bloc/top_bloc.dart';
import 'package:flutter_block_1/models/constants.dart';
import 'package:flutter_block_1/views/app_bloc_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<TopBloc>(create: (_) => TopBloc(
                waitBeforeLoading: const Duration(seconds: 3),
                urls: images),),
            BlocProvider<BottomBloc>(create: (_) => BottomBloc(
                waitBeforeLoading: const Duration(seconds: 3),
                urls: images),),
          ], child: Column(
          mainAxisSize: MainAxisSize.max,
          children: const [
            AppBlocView<TopBloc>(),
            AppBlocView<BottomBloc>()
          ],
        ),
        ),
      ),
    );
  }
}