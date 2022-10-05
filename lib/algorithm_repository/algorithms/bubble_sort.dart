import 'package:sorting_algorithms_visualizer/algorithm_repository/base_algorithm.dart';
import 'package:sorting_algorithms_visualizer/algorithm_cubit/algorithm_cubit.dart';
import 'package:meta/meta.dart';

class BubbleSort extends BaseAlgorithm {
  BubbleSort({@required AlgorithmCubit cubit}) : super(cubit: cubit);

  @override
  Future<void> start() async {
    for (int i = 0; i < this.cubit.state.integers.length - 1; i++) {
      for (int j = 0; j < this.cubit.state.integers.length - i - 1; j++) {
        this.cubit.emitComparisonState(comparisonIndices: [j, j + 1]);

        if (this.cubit.state.integers[j] > this.cubit.state.integers[j + 1]) {
          this.swapArrayElements(i: j, j: j + 1);
        }

        await Future.delayed(this.cubit.state.executionDelay);

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
