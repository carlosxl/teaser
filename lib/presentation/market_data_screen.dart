import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:my_project/containers/market_data.dart';
import 'package:my_project/localizations.dart';
import 'package:my_project/models/app_store.dart';
import 'package:my_project/routes.dart';

class MarketDataScreen extends StatelessWidget {
  final onRefresh;

  MarketDataScreen({this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).title),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.edit);
                },
              ),
            ]
          ),
          body: RefreshIndicator(
            onRefresh: onRefresh,
            child: MarketDataBox(),
         )
        );
      },
    );
  }
}
