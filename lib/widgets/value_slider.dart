import 'package:flutter/material.dart';

class ValueSlider extends StatelessWidget {
  const ValueSlider(
      {Key key,
      @required this.title,
      @required this.value,
      @required this.min,
      @required this.max,
      @required this.onChanged})
      : super(key: key);

  final String title;
  final double value;
  final double min;
  final double max;
  final void Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Min',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Slider(
                  value: value,
                  min: min,
                  max: max,
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Max',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
