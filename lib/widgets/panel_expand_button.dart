import 'package:flutter/material.dart';
import 'package:sorting_algorithms_visualizer/constants.dart';

class PanelExpandButton extends StatelessWidget {
  const PanelExpandButton({Key key, @required this.onPressed})
      : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(kPanelExpansionButtonPadding),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: Colors.grey[850],
          ),
          height: kPanelExpansionButtonHeight,
          width: kPanelExpansionButtonWidth,
        ),
      ),
    );
  }
}
