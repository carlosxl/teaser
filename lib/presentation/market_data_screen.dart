import 'package:flutter/material.dart';

import 'package:my_project/containers/market_data.dart';
import 'package:my_project/localizations.dart';


class MarketDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).title),
      ),
      body: MarketDataBox(),
    );
  }
}
