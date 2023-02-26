import 'dart:async';

import 'package:entity/entity.dart';
import 'package:flutter/material.dart';

import '../../../common/controller/change_notifier_selector.dart';
import '../controller/logs_controller.dart';
import 'log_tile.dart';
import 'logs_scope.dart';

/// {@template logs_screen}
/// LogsScreen widget.
/// {@endtemplate}
class LogsScreen extends StatelessWidget {
  /// {@macro logs_screen}
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: const _LogsList(),
        bottomNavigationBar: SizedBox(
          height: 48,
          child: Material(
            color: Theme.of(context).primaryColor,
            child: Row(
              children: const [
                Expanded(
                  child: Center(child: Text('A')),
                ),
                Expanded(
                  child: Center(child: Text('B')),
                ),
                Expanded(
                  child: Center(child: Text('C')),
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
    scheduleMicrotask(controller.paginate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
      valueListenable: controller.select((controller) => controller.isProcessing, (prev, next) => prev != next),
      builder: (context, isProcessing, child) => CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(
                title: Text('Logs'),
                pinned: true,
                floating: true,
                snap: true,
              ),

              // TODO: Add pinned list

              // Main logs list
              SliverFixedExtentList(
                itemExtent: LogTile.height,
                delegate: SliverChildBuilderDelegate(
                  (context, index) => LogTile(log: Log.placeholder()),
                  childCount: 10,
                ),
              ),

              // Progress indicators
              if (controller.isProcessing)
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
