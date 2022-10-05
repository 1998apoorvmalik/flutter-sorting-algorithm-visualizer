import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sorting_algorithms_visualizer/constants.dart';
import 'package:sorting_algorithms_visualizer/widgets/widgets.dart';

class SlidePanel extends StatefulWidget {
  const SlidePanel({Key key, @required this.panel, @required this.body})
      : super(key: key);

  final Widget panel;
  final Widget body;

  @override
  _SlidePanelState createState() => _SlidePanelState();
}

class _SlidePanelState extends State<SlidePanel> {
  final PanelController _panelController = PanelController();
  PanelState _currentPanelState = PanelState.CLOSED;

  void _togglePanel() {
    if (_currentPanelState == PanelState.OPEN) {
      _currentPanelState = PanelState.CLOSED;
      _panelController.close();
    } else {
      _currentPanelState = PanelState.OPEN;
      _panelController.open();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: _panelController,
      defaultPanelState: _currentPanelState,
      backdropEnabled: true,
      minHeight: kSlidingPanelMinHeight,
      maxHeight: kSlidingPanelMaxHeight,
      color: Colors.black,
      panel: Column(
        children: [
          PanelExpandButton(
            onPressed: () => setState(
              () => _togglePanel(),
            ),
          ),
          widget.panel,
        ],
      ),
      body: widget.body,
    );
  }
}
