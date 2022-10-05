import 'package:flutter/cupertino.dart';
import 'package:sorting_algorithms_visualizer/algorithm_cubit/algorithm_cubit.dart';
import 'package:sorting_algorithms_visualizer/constants.dart';
import 'package:sorting_algorithms_visualizer/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class Visualizer extends StatefulWidget {
  final List<Container> integerDisplayArray = [];

  @override
  _VisualizerState createState() => _VisualizerState();
}

class _VisualizerState extends State<Visualizer> {
  void update({@required AlgorithmState state}) {
    this.widget.integerDisplayArray.clear();

    List<Color> tileColors = [
      Colors.blueGrey,
      Colors.amberAccent,
      Colors.deepPurpleAccent
    ];

    int i = 0;
    state.integers.forEach(
      (element) {
        double elementWidth =
            MediaQuery.of(context).size.width / state.integers.length;
        double elementHeight = (element / state.integers.length) *
            (MediaQuery.of(context).size.height - kSlidingPanelMinHeight);

        this.widget.integerDisplayArray.add(
              Container(
                color: Colors.redAccent,
                height: elementHeight,
                width: elementWidth,
              ),
            );

        if (state.status == AlgorithmExecutionStatus.completed) {
          state.comparisonIndices.forEach(
            (value) {
              if (value == i) {
                this.widget.integerDisplayArray.last = Container(
                    height: elementHeight,
                    width: elementWidth,
                    color: Colors.amberAccent);
              }
            },
          );
        } else {
          state.comparisonIndices.forEach((value) {
            if (value == i) {
              this.widget.integerDisplayArray.last = Container(
                  height: elementHeight,
                  width: elementWidth,
                  color: tileColors.removeLast());
            }
          });
        }
        i++;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlgorithmCubit, AlgorithmState>(
      builder: (context, state) {
        this.update(state: state);
        return Padding(
          padding: const EdgeInsets.only(bottom: kSlidingPanelMinHeight),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: this.widget.integerDisplayArray,
          ),
        );
      },
    );
  }
}
