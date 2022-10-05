import 'package:sorting_algorithms_visualizer/algorithm_repository/base_algorithm.dart';
import 'package:sorting_algorithms_visualizer/algorithm_cubit/algorithm_cubit.dart';
import 'package:meta/meta.dart';

class HeapSort extends BaseAlgorithm {
  HeapSort({@required AlgorithmCubit cubit}) : super(cubit: cubit);
  bool algorithmStopped = false;

  @override
  Future<void> start() async {
    await this.heapSort(this.cubit.state.integers);

    if (!algorithmStopped) {
      super.start();
    }
  }

  Future<void> heapify(List<int> array, int currentIndex, int endIndex) async {
    if (await this.stateListener()) {
      this.cubit.update();
    } else {
      algorithmStopped = true;
      return null;
    }

    int largestIndex = currentIndex;
    final int leftChildIndex = 2 * currentIndex + 1;
    final int rightChildIndex = 2 * currentIndex + 2;

    if (leftChildIndex <= endIndex) {
      this.cubit.emitComparisonState(
          comparisonIndices: [leftChildIndex, largestIndex]);
      await Future.delayed(this.cubit.state.executionDelay);
      if (array[leftChildIndex] > array[largestIndex]) {
        largestIndex = leftChildIndex;
      }
    }

    if (rightChildIndex <= endIndex) {
      this.cubit.emitComparisonState(
          comparisonIndices: [rightChildIndex, largestIndex]);
      await Future.delayed(this.cubit.state.executionDelay);
      if (array[rightChildIndex] > array[largestIndex]) {
        largestIndex = rightChildIndex;
      }
    }

    if (currentIndex != largestIndex) {
      swapArrayElements(i: currentIndex, j: largestIndex);
      this
          .cubit
          .emitComparisonState(comparisonIndices: [currentIndex, largestIndex]);
      await Future.delayed(this.cubit.state.executionDelay);
      await heapify(array, largestIndex, endIndex);
    }
  }

  Future<void> heapSort(List<int> array) async {
    int endIndex = array.length - 1;

    // Convert array to max heap.
    for (int i = (endIndex) ~/ 2; i >= 0; i--) {
      await heapify(array, i, array.length - 1);
    }

    while (endIndex > 0) {
      this.swapArrayElements(i: 0, j: endIndex--);
      await heapify(array, 0, endIndex);
    }
  }
}
