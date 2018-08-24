import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'package:my_project/models/app_store.dart';
import 'package:my_project/models/market_data.dart';
import 'package:my_project/presentation/market_data_list.dart';

class MarketDataBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return MarketDataList(
          marketDataList: vm.marketDataList,
        );
      },
    );
  }
}

class _ViewModel {
  final List<MarketData> marketDataList;

  _ViewModel({
    this.marketDataList,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      marketDataList: store.state.marketDataList,
    );
  }
}
