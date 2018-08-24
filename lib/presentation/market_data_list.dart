import 'package:flutter/material.dart';

import 'package:my_project/models/market_data.dart';
import 'package:my_project/presentation/market_data_row.dart';

class MarketDataList extends StatelessWidget {
  final List<MarketData> marketDataList;

  MarketDataList({
    this.marketDataList = const [],
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: marketDataList.length,
      itemBuilder: (BuildContext context, int index) {
        final marketData = marketDataList[index];

        return MarketDataRow(marketData);
      },
    );
  }
}
