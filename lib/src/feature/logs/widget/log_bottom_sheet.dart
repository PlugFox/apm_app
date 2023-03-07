import 'package:entity/entity.dart';
import 'package:flutter/material.dart';

import 'positioned_draggable_handle.dart';

/// {@template log_bottom_sheet}
/// LogBottomSheet widget.
/// {@endtemplate}
class LogBottomSheet extends StatelessWidget {
  /// {@macro log_bottom_sheet}
  const LogBottomSheet({required this.log, this.controller, super.key});

  static Future<void> show(BuildContext context, Log log) => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        useSafeArea: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        builder: (context) => DraggableScrollableSheet(
          expand: false,
          maxChildSize: .95,
          initialChildSize: .75,
          minChildSize: .25,
          builder: (context, controller) => LogBottomSheet(
            controller: controller,
            log: log,
          ),
        ),
      );

  /// The [Log] to display.
  final Log log;

  /// The [ScrollController] to use for the [ListView].
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Positioned.fill(
            child: RepaintBoundary(
              child: Theme(
                data: Theme.of(context).copyWith(
                  scrollbarTheme: Theme.of(context).scrollbarTheme.copyWith(
                        mainAxisMargin: 12,
                      ),
                ),
                child: CustomScrollView(
                  controller: controller,
                  slivers: <Widget>[
                    _LogBottomSheetAppBar(log: log),
                    _LogBottomSheetBody(log: log),
                  ],
                ),
              ),
            ),
          ),
          const PositionedDraggableHandle(),
        ],
      );
}

class _LogBottomSheetAppBar extends StatelessWidget {
  const _LogBottomSheetAppBar({required this.log});

  final Log log;

  @override
  Widget build(BuildContext context) => SliverAppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        //leadingWidth: 0,
        pinned: true,
        title: Text(
          'Event #${log.id}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: const IconButton(
          icon: Icon(Icons.star_outline),
          splashRadius: 24,
          onPressed: null,
        ),
        actions: <Widget>[
          // TODO(plugfox): Show dialog to confirm deletion with red button and delete log and pop and show snackbar.
          const IconButton(
            icon: Icon(Icons.delete),
            splashRadius: 24,
            onPressed: null,
          ),
          // TODO(plugfox): Copy to clipboard and show snackbar.
          const IconButton(
            icon: Icon(Icons.copy),
            splashRadius: 24,
            onPressed: null,
          ),
          /*
          const IconButton(
            icon: Icon(Icons.share),
            onPressed: null,
          ), */
          IconButton(
            icon: const Icon(Icons.close),
            splashRadius: 24,
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 4),
        ],
      );
}

class _LogBottomSheetBody extends StatelessWidget {
  const _LogBottomSheetBody({required this.log});

  final Log log;

  @override
  Widget build(BuildContext context) => SliverList(
        delegate: SliverChildListDelegate(
          <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                log.event,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            for (var i = 0; i < 100; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  log.event,
                  //log.stackTrace ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
          ],
        ),
      );
}
