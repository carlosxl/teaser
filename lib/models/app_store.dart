import 'package:meta/meta.dart';

import 'package:my_project/models/market_data.dart';

@immutable
class AppState {
  final List<MarketData> marketDataList;

  AppState({
    this.marketDataList = const [],
  });

  factory AppState.initial() => AppState(
        marketDataList: [
          MarketData('EURUSD', '欧元美元', digits: 5),
          MarketData('EURUSD', '欧元美元', digits: 5),
          MarketData('EURUSD', '欧元美元', digits: 5),
          MarketData('EURUSD', '欧元美元', digits: 5),
          MarketData('EURUSD', '欧元美元', digits: 5),
        ],
      );
}
