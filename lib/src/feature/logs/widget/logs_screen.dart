import 'package:entity/entity.dart';
import 'package:flutter/material.dart';

import 'log_tile.dart';

/// {@template logs_screen}
/// LogsScreen widget.
/// {@endtemplate}
class LogsScreen extends StatelessWidget {
  /// {@macro logs_screen}
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              title: Text('Home'),
              pinned: true,
              floating: true,
              snap: true,
            ),
            // TODO: Add pinned list
            SliverFixedExtentList(
              itemExtent: LogTile.height,
              delegate: SliverChildBuilderDelegate(
                (context, index) => LogTile(log: Log.placeholder()),
                childCount: 10000,
              ),
            ),
          ],
        ),
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
