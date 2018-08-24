import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'package:my_project/models/app_store.dart';
import 'package:my_project/reducers/app_state_reducer.dart';
import 'package:my_project/routes.dart';
import 'package:my_project/presentation/market_data_screen.dart';

void main() {
  runApp(FxbMarketDataApp());
}

class FxbMarketDataApp extends StatelessWidget {
  final store = Store<AppState>(
    appStateReducer,
    initialState: AppState.initial(),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'My App',
        theme: ThemeData.dark(),
        routes: {
          FxbMarketDataRoutes.home: (BuildContext context) {
            return StoreBuilder<AppState>(
              builder: (context, store) {
                return MarketDataScreen();
              },
            );
          }
        },
      ),
    );
  }
}
