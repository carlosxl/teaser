import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:my_project/actions/actions.dart';
import 'package:my_project/containers/market_data.dart';
import 'package:my_project/localizations.dart';
import 'package:my_project/models/app_store.dart';

class MarketDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).title),
          ),
          body: MarketDataBox(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              store.dispatch(RefreshAction());
            },
            child: Icon(Icons.refresh),
          ),
        );
      },
    );
  }
}
