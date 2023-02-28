import 'package:entity/entity.dart';
import 'package:flutter/material.dart';

import '../../../common/util/date_util.dart';

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

  static final List<Color> _logColors = <Color>[
    for (var i = 0; i < 5; i++) Colors.transparent,
    Colors.blue, // Debug
    Colors.green, // Config
    Colors.yellow, // Info
    Colors.orange, // Warning
    Colors.red, // Error / Severe / Fatal / Critical / Alert / Emergency / Panic / Failure
  ].map<Color>((e) => e.withOpacity(.1)).toList();

  final Log log;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: _logColors[log.level % _logColors.length],
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Row(
                  children: <Widget>[
                    /* const IconButton(
                        icon: Icon(Icons.push_pin),
                        splashRadius: 24,
                        onPressed: null,
                      ), */
                    const IconButton(
                      icon: Icon(Icons.star_outline),
                      splashRadius: 24,
                      onPressed: null,
                    ),
                    const SizedBox(width: 8),
                    // TODO(plugfox): Use mono font for events.
                    Expanded(
                        child: Text(
                      log.event,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium?.copyWith(),
                    )),
                    Align(
                      alignment: const Alignment(1, .75),
                      child: SizedBox(
                        width: 80,
                        child: Text(
                          DateUtil.format(log.timestamp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: theme.textTheme.labelSmall?.copyWith(height: 1, color: Colors.grey),
                        ),
                      ),
                    ),
                    //Text(log.level.toString()),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 1,
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: theme.dividerColor.withOpacity(.05),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
