import 'dart:math';
import 'package:redux/redux.dart';

import 'package:my_project/actions/actions.dart';
import 'package:my_project/models/app_store.dart';
import 'package:my_project/models/market_data.dart';

const double tickWidth = 0.001; // average tick price change is 0.1%.

final appStateReducer = combineReducers<AppState>([
  TypedReducer<AppState, RefreshAction>(_refresh),
  TypedReducer<AppState, ReorderAction>(_reorder),
  TypedReducer<AppState, ToggleVisibilityAction>(_toggleVisibility),
]);

// TODO: This funciton should take async market data from API return.
AppState _refresh(AppState state, RefreshAction action) {
  Random rg = Random();

  return AppState(
    marketDataList: state.marketDataList.map((data) {
      if (rg.nextBool()) {
        double ratio = 1 + tickWidth * (rg.nextDouble() - 0.5);
        return MarketData.fromPrev(data, ratio);
      }
      return MarketData.fromPrev(data, 1.0);
    }).toList(),
  );
}

AppState _reorder(AppState state, ReorderAction action) {
  int oldIndex = action.oldIndex;
  int newIndex = action.newIndex;

  if (oldIndex < newIndex) {
    newIndex -= 1;
  }

  final List<MarketData> list = state.marketDataList;
  final MarketData data = list.removeAt(oldIndex);
  list.insert(newIndex, data);
  return AppState(marketDataList: list);
}

AppState _toggleVisibility(AppState state, ToggleVisibilityAction action) {
  final List<MarketData> list = state.marketDataList;
  final int index = list.indexWhere((data) => data.name == action.name);
  final MarketData data = list[index];
  list[index] = data.copyWith(isVisible: !data.isVisible);

  return AppState(marketDataList: list);
}
