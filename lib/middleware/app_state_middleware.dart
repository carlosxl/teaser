import 'dart:async';

import 'package:redux/redux.dart';

import 'package:my_project/actions/actions.dart';
import 'package:my_project/models/app_store.dart';

final List<Middleware<AppState>> appStateMiddleware = [
  TypedMiddleware<AppState, CompletableAction>(_refreshIndicatorMiddleware)
];

_refreshIndicatorMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  Future.delayed(Duration(milliseconds: 500)).then((result) {
    store.dispatch(RefreshAction());
    action.completer.complete();
  });

  next(action);
}
