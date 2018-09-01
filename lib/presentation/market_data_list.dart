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
    final List<MarketData> list =
        marketDataList.where((data) => data.isVisible).toList();
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return MarketDataRow(list[index]);
      },
    );
  }
}
