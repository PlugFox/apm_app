import 'package:flutter/foundation.dart' show ChangeNotifier, Listenable, ValueListenable, VoidCallback;

/// Selector from [Listenable]
typedef ChangeNotifierSelector<Controller extends Listenable, Value> = Value Function(
  Controller controller,
);

/// Filter for [Listenable]
typedef ChangeNotifierFilter<Value> = bool Function(Value prev, Value next);

/// {@template change_notifier_selector}
/// Selects a specific value from the [Listenable]
/// for subsequent use in the ValueListenableBuilder
///
/// Listenable -- selector & filter --> ValueListenable<Value>
///
/// For example:
/// ```dart
/// ValueListenableBuilder<Locale>(
///   valueListenable: appModel.select<Locale>(
///     (cn) => cn.locale,
///     (prev, next) => prev.languageCode != next.languageCode
///   ),
///   builder: (context, locale, child) => Text(locale.languageCode),
/// )
/// ```
/// {@endtemplate}
extension ChangeNotifierSelectorExtension<Controller extends Listenable> on Controller {
  /// Transform [Listenable] in to [ValueListenable]
  ///
  /// {@macro change_notifier_selector}
  ValueListenable<Value> select<Value>(
    ChangeNotifierSelector<Controller, Value> selector, [
    ChangeNotifierFilter<Value>? test,
  ]) =>
      _ValueListenableView<Controller, Value>(this, selector, test);
}

/// {@nodoc}
class _ValueListenableView<Controller extends Listenable, Value> with ChangeNotifier implements ValueListenable<Value> {
  _ValueListenableView(
    Controller controller,
    ChangeNotifierSelector<Controller, Value> selector,
    ChangeNotifierFilter<Value>? test,
  )   : _controller = controller,
        _selector = selector,
        _test = test;

  final Controller _controller;
  final ChangeNotifierSelector<Controller, Value> _selector;
  final ChangeNotifierFilter<Value>? _test;
  bool _isDisposed = false;

  @override
  Value get value => hasListeners ? _$value : _selector(_controller);

  late Value _$value;

  void _update() {
    if (_isDisposed) return;
    final newValue = _selector(_controller);
    if (identical(_$value, newValue)) return;
    if (!(_test?.call(_$value, newValue) ?? true)) return;
    _$value = newValue;
    notifyListeners();
  }

  @override
  void addListener(VoidCallback listener) {
    if (_isDisposed) return;
    if (!hasListeners) {
      _$value = _selector(_controller);
      _controller.addListener(_update);
    }
    super.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    if (_isDisposed) return;
    super.removeListener(listener);
    if (!hasListeners) _controller.removeListener(_update);
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller.removeListener(_update);
    super.dispose();
  }
}
