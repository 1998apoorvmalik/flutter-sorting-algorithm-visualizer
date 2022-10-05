import 'package:sorting_algorithms_visualizer/enums.dart';

// Algorithm Option;
const DEFAULT_ALGORITHM_TYPE = AlgorithmType.Bubble;

const MIN_EXEC_DELAY = 500;
const DEFAULT_EXEC_DELAY = 5000;
const MAX_EXEC_DELAY = 200000;

const MIN_BARS = 10;
const DEFAULT_BARS = 125;
const MAX_BARS = 250;

// Panel Expansion Button
const double kPanelExpansionButtonHeight = 6;
const double kPanelExpansionButtonWidth = 42;
const double kPanelExpansionButtonPadding = 8.0;

// (kContentVerticalSpacing / 2) + (kPanelExpansionButtonPadding * 2) + kPanelExpansionButtonHeight

// Panel Component.
const double kSlidingPanelMinHeight = kContentVerticalSpacing +
    (4 * kPanelExpansionButtonPadding) +
    (2 * kPanelExpansionButtonHeight) +
    kSortButtonHeight;
const double kSlidingPanelMaxHeight = 360;

// Controller Component.
const double kContentVerticalSpacing = 24;
const double kSortButtonHeight = 36;
const double kButtonWidth = 86;
