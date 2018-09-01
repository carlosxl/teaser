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
