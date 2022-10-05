import 'package:sorting_algorithms_visualizer/algorithm_repository/base_algorithm.dart';
import 'package:sorting_algorithms_visualizer/algorithm_cubit/algorithm_cubit.dart';
import 'package:meta/meta.dart';

class SelectionSort extends BaseAlgorithm {
  SelectionSort({@required AlgorithmCubit cubit}) : super(cubit: cubit);
  bool algorithmStopped = false;

  Future<void> selectionSort({int start: 0}) async {
    if (start < this.cubit.state.integers.length) {
      int minIndex = start;
      for (int i = start; i < this.cubit.state.integers.length; i++) {
        if (await this.stateListener()) {
          this.cubit.update();
        } else {
          algorithmStopped = true;
          return;
        }

        this.cubit.emitComparisonState(comparisonIndices: [start, i]);
        await Future.delayed(this.cubit.state.executionDelay);

        if (this.cubit.state.integers[minIndex] >
            this.cubit.state.integers[i]) {
          minIndex = i;
        }
      }
      swapArrayElements(i: minIndex, j: start);
      await selectionSort(start: start + 1);
    }
  }

  @override
  Future<void> start() async {
    await selectionSort();
    if (!algorithmStopped) {
      super.start();
    }
  }
}
