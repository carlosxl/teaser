import 'dart:math';
import 'package:redux/redux.dart';

import 'package:my_project/actions/actions.dart';
import 'package:my_project/models/app_store.dart';
import 'package:my_project/models/market_data.dart';

const double tickWidth = 0.0002;

final appStateReducer = combineReducers<AppState>([
  TypedReducer<AppState, RefreshAction>(_refresh),
]);

AppState _refresh(AppState state, RefreshAction action) {
  Random rg = Random();

  return AppState(
    marketDataList: state.marketDataList.map((data) {
      if (rg.nextBool()) {
        double diff = tickWidth * (rg.nextDouble() - 0.5);
        return MarketData.fromPrev(data, diff);
      }
      return MarketData.fromPrev(data, 0.0);
    }).toList(),
  );
}
