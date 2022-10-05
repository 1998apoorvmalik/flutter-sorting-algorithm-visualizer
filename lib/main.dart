import 'package:flutter/cupertino.dart';
import 'package:sorting_algorithms_visualizer/algorithm_cubit/algorithm_cubit.dart';
import 'package:sorting_algorithms_visualizer/components/components.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import "package:flutter/material.dart";

void main() => runApp(
      MaterialApp(
        theme: ThemeData.dark().copyWith(
          accentColor: Colors.redAccent,
          scaffoldBackgroundColor: Colors.black,
          buttonColor: Colors.amberAccent,
          sliderTheme: SliderThemeData(
              activeTrackColor: Colors.redAccent,
              inactiveTrackColor: CupertinoColors.darkBackgroundGray,
              thumbColor: Colors.redAccent,
              overlayColor: Colors.transparent),
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SortingAlgorithmsVisualizerApp(),
        ),
      ),
    );

class SortingAlgorithmsVisualizerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlgorithmCubit(),
      child: SlidePanel(
        panel: Controller(),
        body: Visualizer(),
      ),
    );
  }
}
