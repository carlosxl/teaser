import 'dart:async';

class RefreshAction {}

class CompletableAction {
  final Completer completer;

  CompletableAction({Completer completer})
      : this.completer = completer ?? Completer();
}
