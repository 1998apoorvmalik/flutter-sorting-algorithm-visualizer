import 'package:sorting_algorithms_visualizer/algorithm_repository/base_algorithm.dart';
import 'package:sorting_algorithms_visualizer/algorithm_cubit/algorithm_cubit.dart';
import 'package:meta/meta.dart';

class InsertionSort extends BaseAlgorithm {
  InsertionSort({@required AlgorithmCubit cubit}) : super(cubit: cubit);

  @override
  Future<void> start() async {
    for (int i = 1; i < this.cubit.state.integers.length; i++) {
      int j = i;

      while (j > 0) {
        this.cubit.emitComparisonState(comparisonIndices: [i, j]);
        await Future.delayed(this.cubit.state.executionDelay);

        if (this.cubit.state.integers[j] < this.cubit.state.integers[j - 1]) {
          this.swapArrayElements(i: j, j: j - 1);
          j--;
        } else {
          break;
        }

        if (await this.stateListener()) {
          this.cubit.update();
        } else {
          return;
        }
      }
    }
    super.start();
  }
}
