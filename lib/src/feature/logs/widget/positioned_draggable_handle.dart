import 'package:flutter/material.dart';

/// {@template positioned_draggable_handle}
/// PositionedDraggableHandle widget.
/// {@endtemplate}
class PositionedDraggableHandle extends StatelessWidget {
  /// {@macro positioned_draggable_handle}
  const PositionedDraggableHandle({super.key});

  @override
  Widget build(BuildContext context) => Positioned(
        left: 0,
        right: 0,
        top: 8,
        height: 4,
        child: Center(
          child: Container(
            width: 32,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      );
}
