import 'package:sorting_algorithms_visualizer/algorithm_repository/base_algorithm.dart';
import 'package:sorting_algorithms_visualizer/algorithm_cubit/algorithm_cubit.dart';
import 'package:meta/meta.dart';

class QuickSort extends BaseAlgorithm {
  QuickSort({@required AlgorithmCubit cubit}) : super(cubit: cubit);
  bool algorithmStopped = false;

  @override
  Future<void> start() async {
    await this.quickSort(
        this.cubit.state.integers, 0, this.cubit.state.integers.length - 1);

    if (!algorithmStopped) {
      super.start();
    }
  }

  Future<void> quickSort(List<int> array, int low, int high) async {
    if (low < high) {
      int p = await partition(low, high);

      if (p == null) {
        return;
      }
      await quickSort(array, low, p - 1);
      await quickSort(array, p + 1, high);
    }
  }

  Future<int> partition(int low, int high) async {
    int i = low - 1;

    while (low < high) {
      this.cubit.emitComparisonState(comparisonIndices: [low, i, high]);
      await Future.delayed(this.cubit.state.executionDelay);

      if (this.cubit.state.integers[low] < this.cubit.state.integers[high]) {
        swapArrayElements(i: ++i, j: low);
        if (await this.stateListener()) {
          this.cubit.update();
        } else {
          algorithmStopped = true;
          return null;
        }
      }
      low++;
    }

    this.cubit.emitComparisonState(comparisonIndices: [i, high]);
    await Future.delayed(this.cubit.state.executionDelay);
    swapArrayElements(i: ++i, j: high);
    if (await this.stateListener()) {
      this.cubit.update();
    } else {
      algorithmStopped = true;
      return null;
    }
    return i;
  }
}
