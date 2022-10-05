import 'package:sorting_algorithms_visualizer/algorithm_repository/base_algorithm.dart';
import 'package:sorting_algorithms_visualizer/algorithm_cubit/algorithm_cubit.dart';
import 'package:meta/meta.dart';

class MergeSort extends BaseAlgorithm {
  MergeSort({@required AlgorithmCubit cubit}) : super(cubit: cubit);
  bool algorithmStopped = false;

  @override
  Future<void> start() async {
    await this.mergeSort(
        this.cubit.state.integers, 0, this.cubit.state.integers.length - 1);
    if (!algorithmStopped) {
      super.start();
    }
  }

  int nextGap(gap) {
    if (gap <= 1) {
      return 0;
    }

    return (gap / 2).ceil();
  }

  Future<void> merge(List<int> arr, int start, int end) async {
    if (await this.stateListener()) {
      this.cubit.update();
    } else {
      algorithmStopped = true;
      return null;
    }
    int gap = end - start + 1;
    gap = nextGap(gap);

    while (gap > 0) {
      int i = start;
      while (i + gap <= end) {
        int j = i + gap;

        this.cubit.emitComparisonState(comparisonIndices: [i, j]);
        await Future.delayed(this.cubit.state.executionDelay);
        if (this.cubit.state.integers[i] > this.cubit.state.integers[j]) {
          this.swapArrayElements(i: i, j: j);
        }
        if (await this.stateListener()) {
          this.cubit.update();
        } else {
          algorithmStopped = true;
          return null;
        }

        i++;
      }

      gap = nextGap(gap);
    }
  }

  Future<void> mergeSort(List<int> arr, int l, int r) async {
    if (await this.stateListener()) {
      this.cubit.update();
    } else {
      algorithmStopped = true;
      return null;
    }
    if (l < r) {
      int m = l + ((r - l) ~/ 2);
      await mergeSort(arr, l, m);
      await mergeSort(arr, m + 1, r);
      await merge(arr, l, r);
    }
  }
}
