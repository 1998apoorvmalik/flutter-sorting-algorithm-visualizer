import 'package:sorting_algorithms_visualizer/enums.dart';
import '../algorithm_cubit/algorithm_cubit.dart';
import 'package:meta/meta.dart';

abstract class BaseAlgorithm {
  final AlgorithmCubit cubit;

  BaseAlgorithm({@required this.cubit});

  Future<bool> stateListener() async {
    if (this.cubit.state.status == AlgorithmExecutionStatus.executing) {
      return true;
    } else if (this.cubit.state.status == AlgorithmExecutionStatus.initial) {
      return false;
    } else {
      await Future.delayed(Duration(milliseconds: 10));
      return stateListener();
    }
  }

  void swapArrayElements({@required int i, @required int j}) {
    int temp = this.cubit.state.integers[i];
    this.cubit.state.integers[i] = this.cubit.state.integers[j];
    this.cubit.state.integers[j] = temp;
  }

  Future<void> start() async {
    // Implement this method in the sub class.
    await this.cubit.complete();
  }
}
