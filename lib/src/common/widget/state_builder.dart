import 'package:flutter/widgets.dart';

import '../controller/state_controller.dart';

class StateBuilder<S extends Object> extends StatefulWidget {
  const StateBuilder({
    super.key,
    required this.controller,
    required this.builder,
    this.test,
  });

  final IStateController<S> controller;

  final Widget Function(BuildContext context, S state) builder;
  final bool Function(S prev, S next)? test;

  @override
  State<StatefulWidget> createState() => _StateBuilder$State<S>();
}

class _StateBuilder$State<S extends Object> extends State<StateBuilder<S>> {
  late S state;

  @override
  void initState() {
    super.initState();
    state = widget.controller.state;
    widget.controller.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(covariant StateBuilder<S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_valueChanged);
      state = widget.controller.state;
      widget.controller.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() {
    if (!(widget.test?.call(state, widget.controller.state) ?? true)) return;
    setState(() => state = widget.controller.state);
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, state);
}
