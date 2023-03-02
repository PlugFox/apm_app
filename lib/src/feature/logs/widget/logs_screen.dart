import 'dart:async';

import 'package:entity/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../common/widget/state_builder.dart';
import '../controller/logs_controller.dart';
import '../controller/logs_state.dart';
import 'log_tile.dart';
import 'logs_scope.dart';
import 'logs_search_bar.dart';

/// {@template logs_screen}
/// LogsScreen widget.
/// {@endtemplate}
class LogsScreen extends StatelessWidget {
  /// {@macro logs_screen}
  const LogsScreen({super.key});

  static final GlobalKey<ScaffoldState> _key =
      GlobalKey<ScaffoldState>(debugLabel: 'LogsScreen#GlobalKey<ScaffoldState>');

  @override
  Widget build(BuildContext context) => Scaffold(
        key: _key,
        body: const _LogsList(),
        bottomNavigationBar: SizedBox(
          height: 32,
          child: Material(
            color: Theme.of(context).primaryColor,
            elevation: 4,
            child: Row(
              children: const [
                Expanded(
                  child: Center(
                    child: Tooltip(
                      message: 'A',
                      showDuration: Duration(milliseconds: 750),
                      waitDuration: Duration(milliseconds: 500),
                      child: Text('A'),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Tooltip(
                      message: 'B',
                      showDuration: Duration(milliseconds: 750),
                      waitDuration: Duration(milliseconds: 500),
                      child: Text('B'),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Tooltip(
                      message: 'C',
                      showDuration: Duration(milliseconds: 750),
                      waitDuration: Duration(milliseconds: 500),
                      child: Text('C'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _LogsList extends StatefulWidget {
  const _LogsList();

  @override
  State<_LogsList> createState() => _LogsListState();
}

class _LogsListState extends State<_LogsList> {
  late final ILogsController controller;

  @override
  void initState() {
    controller = LogsScope.controllerOf(context);
    SchedulerBinding.instance.addPostFrameCallback((_) => mounted ? controller.paginate() : null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StateBuilder<LogsState>(
      controller: controller,
      test: (prev, next) => prev.isProcessing != next.isProcessing,
      builder: (context, state) => CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: const Text(
                  'Events',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                backgroundColor: Theme.of(context).primaryColor,
                toolbarHeight: kToolbarHeight,
                bottom: const LogsSearchBar(),
                pinned: MediaQuery.of(context).size.height > 600,
                floating: true,
                snap: true,
              ),

              // TODO: Add pinned list
              /* SliverFixedExtentList(
                itemExtent: LogTile.height,
                delegate: SliverChildBuilderDelegate(
                  (context, index) => LogTile(log: Log.placeholder()),
                  childCount: 5,
                ),
              ), */

              // Main logs list
              const _LogsSliverList(),

              // Progress indicators
              if (state.isProcessing)
                SliverFixedExtentList(
                  itemExtent: LogTile.height,
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => LogTile.skeleton,
                    childCount: 5,
                  ),
                ),
            ],
          ));
}

class _LogsSliverList extends StatelessWidget {
  const _LogsSliverList();

  /// Emits a new value every day to update the list.
  static final Stream<void> _dayTicker = Stream<void>.periodic(const Duration(minutes: 1), (i) => i)
      .map((i) => DateTime.now().day)
      .distinct()
      .asBroadcastStream();

  @override
  Widget build(BuildContext context) {
    final logs = LogsScope.logsOf(context, listen: true);
    return StreamBuilder<void>(
        stream: _dayTicker,
        builder: (context, _) => SliverFixedExtentList(
              itemExtent: LogTile.height,
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final log = logs[index];
                  return LogTile(key: ValueKey<LogID>(log.id), log: log);
                },
                childCount: logs.length,
              ),
            ));
  }
}
