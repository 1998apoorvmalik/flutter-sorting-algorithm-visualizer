import 'package:sorting_algorithms_visualizer/algorithm_cubit/algorithm_cubit.dart';
import 'package:sorting_algorithms_visualizer/constants.dart';
import 'package:sorting_algorithms_visualizer/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorting_algorithms_visualizer/widgets/value_slider.dart';

class Controller extends StatefulWidget {
  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  double _currentExecutionSpeedSliderValue;
  double _currentBarNumberSliderValue;
  List<Text> _algorithmsSelectionNames = [];
  int _selectedAlgorithmIndex = 0;

  @override
  Widget build(BuildContext context) {
    _algorithmsSelectionNames.clear();
    AlgorithmType.values.forEach((element) {
      String value = element.toString().split('.')[1];
      _algorithmsSelectionNames.add(
        Text(
          value,
          style: TextStyle(color: Colors.white),
        ),
      );
    });
    _algorithmsSelectionNames[_selectedAlgorithmIndex] = Text(
      _algorithmsSelectionNames[_selectedAlgorithmIndex].data,
      style: TextStyle(color: Colors.black),
    );
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<AlgorithmCubit, AlgorithmState>(
        builder: (context, state) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth / 25,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: kContentVerticalSpacing / 2,
            ),
            SizedBox(
              height: kSortButtonHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Time Elapsed: 0.000s",
                    style: TextStyle(color: Colors.amberAccent, fontSize: 18),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: kButtonWidth,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).buttonColor),
                          onPressed: () {
                            switch (state.status) {
                              case AlgorithmExecutionStatus.initial:
                                context.read<AlgorithmCubit>().start();
                                break;
                              case AlgorithmExecutionStatus.executing:
                                context.read<AlgorithmCubit>().pause();
                                break;
                              case AlgorithmExecutionStatus.paused:
                                context.read<AlgorithmCubit>().resume();
                                break;
                              case AlgorithmExecutionStatus.completed:
                                break;
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              state.status == AlgorithmExecutionStatus.executing
                                  ? "Pause"
                                  : " Sort ",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: kButtonWidth,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).accentColor),
                          onPressed: () =>
                              context.read<AlgorithmCubit>().reset(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Reset",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: (kContentVerticalSpacing / 2) +
                  (kPanelExpansionButtonPadding * 2) +
                  kPanelExpansionButtonHeight,
            ),
            CupertinoSlidingSegmentedControl(
              groupValue: this._selectedAlgorithmIndex,
              children: _algorithmsSelectionNames.asMap(),
              backgroundColor: CupertinoColors.darkBackgroundGray,
              thumbColor: Theme.of(context).buttonColor,
              onValueChanged: (newIndex) {
                this.setState(
                  () {
                    this._selectedAlgorithmIndex = newIndex;
                    context.read<AlgorithmCubit>().changeAlgorithmTyoe(
                        newAlgorithmType: AlgorithmType.values[newIndex]);
                  },
                );
              },
            ),
            SizedBox(
              height: kContentVerticalSpacing,
            ),
            ValueSlider(
              title: 'Sorting Speed',
              value: _currentExecutionSpeedSliderValue ??
                  (MAX_EXEC_DELAY - DEFAULT_EXEC_DELAY + MIN_EXEC_DELAY)
                      .toDouble(),
              min: MIN_EXEC_DELAY.toDouble(),
              max: MAX_EXEC_DELAY.toDouble(),
              onChanged: (value) {
                setState(() {
                  _currentExecutionSpeedSliderValue = value;
                });

                int microseconds =
                    (MAX_EXEC_DELAY - value + MIN_EXEC_DELAY).toInt();

                Duration newDuration = Duration(microseconds: microseconds);

                context.read<AlgorithmCubit>().changeExecutionSpeed(
                      executionSpeed: newDuration,
                    );
              },
            ),
            SizedBox(
              height: kContentVerticalSpacing / 2,
            ),
            ValueSlider(
              title: 'Number of bars',
              value: _currentBarNumberSliderValue ?? DEFAULT_BARS.toDouble(),
              min: MIN_BARS.toDouble(),
              max: MAX_BARS.toDouble(),
              onChanged: (value) {
                setState(() {
                  this._currentBarNumberSliderValue = value;
                });
                context
                    .read<AlgorithmCubit>()
                    .changeNumberOfBars(numberOfbars: value.toInt());
              },
            ),
          ],
        ),
      );
    });
  }
}
