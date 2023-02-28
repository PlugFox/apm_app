import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

/// {@template window_scope}
/// WindowScope widget.
/// {@endtemplate}
class WindowScope extends StatelessWidget {
  /// {@macro window_scope}
  const WindowScope({
    required this.child,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) => io.Platform.isAndroid || io.Platform.isIOS
      ? child
      : Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _WindowTitle(),
            Expanded(
              child: child,
            ),
          ],
        );
}

class _WindowTitle extends StatefulWidget {
  const _WindowTitle();

  @override
  State<_WindowTitle> createState() => _WindowTitleState();
}

class _WindowTitleState extends State<_WindowTitle> with WindowListener {
  final ValueNotifier<bool> _isFullScreen = ValueNotifier(false);

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowEnterFullScreen() {
    super.onWindowEnterFullScreen();
    _isFullScreen.value = true;
  }

  @override
  void onWindowLeaveFullScreen() {
    super.onWindowLeaveFullScreen();
    _isFullScreen.value = false;
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 24,
        child: DragToMoveArea(
          child: Material(
            color: Theme.of(context).primaryColor,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Builder(
                  builder: (context) {
                    final size = MediaQuery.of(context).size;
                    return AnimatedPositioned(
                      duration: const Duration(milliseconds: 350),
                      left: size.width < 800 ? 8 : 78,
                      right: 78,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          transitionBuilder: (child, animation) => FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(
                              scale: animation,
                              child: child,
                            ),
                          ),
                          child: Text(
                            key: ValueKey<bool>(size.width < 400),
                            size.width < 400 ? 'APM' : 'Application Performance Monitoring',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(height: 1),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                _WindowButtons$Windows(isFullScreen: _isFullScreen),
              ],
            ),
          ),
        ),
      );
}

class _WindowButtons$Windows extends StatelessWidget {
  const _WindowButtons$Windows({
    required ValueListenable<bool> isFullScreen,
  }) : _isFullScreen = isFullScreen;

  final ValueListenable<bool> _isFullScreen;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _WindowButton(
            onPressed: () => windowManager.minimize(),
            icon: Icons.minimize,
          ),
          ValueListenableBuilder<bool>(
              valueListenable: _isFullScreen,
              builder: (context, isFullScreen, _) => _WindowButton(
                    onPressed: () => windowManager.setFullScreen(!isFullScreen),
                    icon: isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                  )),
          _WindowButton(
            onPressed: () => windowManager.close(),
            icon: Icons.close,
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

class _WindowButton extends StatelessWidget {
  const _WindowButton({
    required this.onPressed,
    required this.icon,
  });

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          iconSize: 16,
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          splashRadius: 12,
          constraints: const BoxConstraints.tightFor(width: 24, height: 24),
        ),
      );
}
