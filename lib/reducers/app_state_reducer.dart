import 'dart:math';
import 'package:redux/redux.dart';

import 'package:my_project/actions/actions.dart';
import 'package:my_project/models/app_store.dart';
import 'package:my_project/models/market_data.dart';

const double tickWidth = 0.001;  // average tick price change is 0.1%.

final appStateReducer = combineReducers<AppState>([
  TypedReducer<AppState, RefreshAction>(_refresh),
  TypedReducer<AppState, ReorderAction>(_reorder),
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
