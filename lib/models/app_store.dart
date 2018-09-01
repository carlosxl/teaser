import 'package:meta/meta.dart';

import 'package:my_project/models/market_data.dart';

@immutable
class AppState {
  final List<MarketData> marketDataList;
  final bool isLoading;

  AppState({
    this.marketDataList = const [],
    this.isLoading = false,
  });

  factory AppState.initial() => AppState(
        marketDataList: [
          MarketData("EURUSD", "欧元美元", digits: 5),
          MarketData("USDJPY", "美元日元", digits: 3),
          MarketData("GBPUSD", "英镑美元", digits: 5),
          MarketData("USDCHF", "美元瑞郎", digits: 5),
          MarketData("USDCAD", "美元加元", digits: 5),
          MarketData("AUDUSD", "澳元美元", digits: 5),
          MarketData("NZDUSD", "纽元美元", digits: 5),
          MarketData("EURJPY", "欧元日元", digits: 3),
          MarketData("EURGBP", "欧元英镑", digits: 5),
          MarketData("EURCHF", "欧元瑞郎", digits: 5),
          MarketData("GBPJPY", "英镑日元", digits: 3),
          MarketData("GBPCHF", "英镑瑞郎", digits: 5),
          MarketData("AUDJPY", "澳元日元", digits: 3),
          MarketData("CADJPY", "加元日元", digits: 3),
          MarketData("NZDJPY", "纽元日元", digits: 3),
          MarketData("EURAUD", "欧元澳元", digits: 5),
          MarketData("EURNZD", "欧元纽元", digits: 5),
          MarketData("EURCAD", "欧元加元", digits: 5),
          MarketData("GBPAUD", "英镑澳元", digits: 5),
          MarketData("GBPNZD", "英镑纽元", digits: 5),
          MarketData("GBPCAD", "英镑加元", digits: 5),
          MarketData("AUDNZD", "澳元纽元", digits: 5)
        ],
      );
}
