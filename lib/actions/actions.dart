import 'dart:async';

class CompletableAction {
  final Completer completer;

  CompletableAction({Completer completer})
      : this.completer = completer ?? Completer();
}

class RefreshAction {}

class ReorderAction {
  final int oldIndex;
  final int newIndex;

  ReorderAction(this.oldIndex, this.newIndex);
}

/// Toggle the `isVisible` value of a MarketData instance identified by its `name`.
class ToggleVisibilityAction {
  final String name;
  final bool value;

  ToggleVisibilityAction(this.name, this.value);
}