import 'package:flutter/foundation.dart';

import 'controller.dart';

abstract class IStateController<State extends Object> implements IController {
  /// The current state of the controller.
  State get state;
}

abstract class StateController<State extends Object> extends Controller implements IStateController<State> {
  StateController(State initialState) : _$state = initialState;

  @override
  @nonVirtual
  State get state => _$state;
  State _$state;

  @protected
  @nonVirtual
  void setState(State state) {
    _$state = state;
    if (isDisposed) return;
    notifyListeners();
  }
}
