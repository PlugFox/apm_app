import 'package:entity/entity.dart';
import 'package:flutter/material.dart';

/// {@template log_tile}
/// LogTile widget.
/// {@endtemplate}
class LogTile extends StatelessWidget {
  /// {@macro log_tile}
  const LogTile({required this.log, super.key});

  /// Skeleton of the tile.
  static Widget skeleton = SizedBox(
    height: height,
    child: Material(
      color: Colors.grey.withOpacity(.5),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );

  /// Height of the tile.
  static const double height = 56;

  final Log log;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        child: Row(
          children: <Widget>[
            const Icon(Icons.info),
            Text(log.timestamp.toString()),
            Expanded(child: Text(log.event)),
            Text(log.level.toString()),
          ],
        ),
      );
}
