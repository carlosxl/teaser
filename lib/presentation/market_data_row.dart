import 'package:flutter/material.dart';

import 'package:my_project/models/market_data.dart';

class MarketDataRow extends StatelessWidget {
  final MarketData data;

  MarketDataRow(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(data.name),
              Text(data.nameLocal),
            ],
          ),
          Column(
            children: <Widget>[
              Text(data.bid.toString()),
              Text(data.high.toString()),
            ],
          ),
          Column(
            children: <Widget>[
              Text(data.ask.toString()),
              Text(data.low.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
