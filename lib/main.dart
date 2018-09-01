import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'package:my_project/actions/actions.dart';
import 'package:my_project/localizations.dart';
import 'package:my_project/middleware/app_state_middleware.dart';
import 'package:my_project/models/app_store.dart';
import 'package:my_project/presentation/edit_list_screen.dart';
import 'package:my_project/presentation/market_data_screen.dart';
import 'package:my_project/reducers/app_state_reducer.dart';
import 'package:my_project/routes.dart';

void main() {
  runApp(FxbMarketDataApp());
}

class FxbMarketDataApp extends StatelessWidget {
  final store = Store<AppState>(
    appStateReducer,
    initialState: AppState.initial(),
    middleware: appStateMiddleware,
  );

  @override
  Widget build(BuildContext context) {
    onRefresh() {
      final CompletableAction action = CompletableAction();
      store.dispatch(action);

      return action.completer.future;
    }

    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: AppLocalizations().appTitle,
        theme: ThemeData.light(),
        localizationsDelegates: [
          AppLocalizationsDelegate(),
        ],
        supportedLocales: [
          const Locale('zh', 'CN'),
          const Locale('zh', 'HK'),
          const Locale('en', 'US'),
        ],
        routes: {
          AppRoutes.home: (BuildContext context) {
            return MarketDataScreen(onRefresh: onRefresh);
          },
          AppRoutes.edit: (BuildContext context) {
            return EditListScreen();
          },
        },
      ),
    );
  }
}
