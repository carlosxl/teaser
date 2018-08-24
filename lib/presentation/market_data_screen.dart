import 'package:flutter/material.dart';

import 'package:my_project/containers/market_data.dart';


class MarketDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('金汇行情'),
      ),
      body: MarketDataBox(),
    );
  }
}
