import 'package:sorting_algorithms_visualizer/algorithm_repository/algorithms.dart';
import 'package:sorting_algorithms_visualizer/constants.dart';
import 'package:sorting_algorithms_visualizer/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'algorithm_state.dart';

class AlgorithmCubit extends Cubit<AlgorithmState> {
  BaseAlgorithm algorithm;

  static List<int> generateIntegerList({@required int numberOfIntegers}) {
    List<int> numbersArray = [];

    for (int i = 1; i <= numberOfIntegers; i++) {
      numbersArray.add(i);
    }

    numbersArray.shuffle();
    return numbersArray;
  }

  AlgorithmCubit()
      : super(
          AlgorithmState(
            type: DEFAULT_ALGORITHM_TYPE,
            integers: generateIntegerList(numberOfIntegers: DEFAULT_BARS),
            status: AlgorithmExecutionStatus.initial,
            executionDelay: const Duration(microseconds: DEFAULT_EXEC_DELAY),
          ),
        ) {
    this._updateAlgorithm();
  }

  void _updateAlgorithm() {
    switch (this.state.type) {
      case AlgorithmType.Bubble:
        this.algorithm = BubbleSort(cubit: this);
        break;
      case AlgorithmType.Quick:
        this.algorithm = QuickSort(cubit: this);
        break;
      case AlgorithmType.Insertion:
        this.algorithm = InsertionSort(cubit: this);
        break;
      case AlgorithmType.Merge:
        this.algorithm = MergeSort(cubit: this);
        break;
      case AlgorithmType.Selection:
        this.algorithm = SelectionSort(cubit: this);
        break;
      case AlgorithmType.Heap:
        this.algorithm = HeapSort(cubit: this);
        break;
    }
  }

  void changeExecutionSpeed({@required Duration executionSpeed}) {
    emit(state.copyWith(algorithmSpeed: executionSpeed));
  }

  void changeAlgorithmTyoe({@required AlgorithmType newAlgorithmType}) {
    this.reset(
        newAlgorithmType: newAlgorithmType,
        resetIntegerArray:
            this.state.status == AlgorithmExecutionStatus.completed
                ? true
                : false);
  }

  void changeNumberOfBars({@required int numberOfbars}) {
    this.reset(numberOfBars: numberOfbars);
  }

  void emitComparisonState({@required List<int> comparisonIndices}) {
    if (state.status != AlgorithmExecutionStatus.initial) {
      emit(state.copyWith(comparisonIndices: comparisonIndices));
    }
  }

  void reset(
      {AlgorithmType newAlgorithmType,
      int numberOfBars,
      bool resetIntegerArray = true}) {
    emit(this.state.copyWith(
      integerArray: resetIntegerArray
          ? generateIntegerList(
              numberOfIntegers: numberOfBars ?? this.state.integers.length)
          : this.state.integers,
      status: AlgorithmExecutionStatus.initial,
      type: newAlgorithmType ?? this.state.type,
      comparisonIndices: const [],
    ));
    this._updateAlgorithm();
  }

  void pause() {
    emit(this.state.copyWith(
          status: AlgorithmExecutionStatus.paused,
        ));
  }

  void resume() {
    emit(this.state.copyWith(status: AlgorithmExecutionStatus.executing));
  }

  void start() {
    emit(this.state.copyWith(status: AlgorithmExecutionStatus.executing));
    this.algorithm.start();
  }

  void update() {
    emit(this.state);
  }

  Future<void> complete() async {
    emit(this.state.copyWith(status: AlgorithmExecutionStatus.completed));
    List<int> comparisonIndices = [];
    for (int i = 0; i < this.state.integers.length; i++) {
      comparisonIndices.add(i);
      this.emitComparisonState(comparisonIndices: comparisonIndices);
      await Future.delayed(Duration(milliseconds: 10));
    }
  }
}
