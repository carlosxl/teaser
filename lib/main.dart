import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'models/zoomed_price.dart';
import 'redux.dart';

var rng = new Random();

void main() {
  final store = new Store<PricesState>(
    reducer,
    initialState: PricesState.initial(),
  );

  runApp(new MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<PricesState> store;

  MyApp({Key key, this.store}) : super(key: key);

  Future<Null> _handleRefresh(Store store) {
    final Completer<Null> completer = new Completer<Null>();
    new Timer(const Duration(seconds: 3), () {
      completer.complete(null);
    });

    store.dispatch(Actions.Refresh);

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<PricesState>(
      store: store,
      child: new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: new Scaffold(
            appBar: new AppBar(
              title: new Text('贵金属行情'),
            ),
            body: new StoreConnector<PricesState, dynamic>(
              converter: (Store store) {
                return () => _handleRefresh(store);
              },
              builder: (context, callback) {
                return RefreshIndicator(
                  onRefresh: callback,
                  child: new MarketDataScreen(),
                );
              },
            )),
      ),
    );
  }
}

class MarketDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<PricesState, List<ContractPrice>>(
        converter: (store) => store.state.contractPrices,
        builder: (BuildContext context, List<ContractPrice> contractPrices) {
          return new ListView(
            children: contractPrices
                .map((contractPrice) => MarketDataRow(contractPrice))
                .toList(),
          );
        });
  }
}

class MarketDataRow extends StatelessWidget {
  final ContractPrice contractPrice;

  MarketDataRow(this.contractPrice);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new Expanded(
              child: new Container(
            padding: EdgeInsets.only(left: 15.0),
            child: new ContractName(
                contractPrice.contractName, contractPrice.contractNameLocal),
          )),
          new Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: new PriceColumn(contractPrice.bid, contractPrice.low, '最低价'),
          ),
          new Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child:
                new PriceColumn(contractPrice.ask, contractPrice.high, '最高价'),
          ),
        ],
      ),
    );
  }
}

class ContractName extends StatelessWidget {
  final String _nameChi;
  final String _nameEng;

  ContractName(this._nameEng, this._nameChi) : super();

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          _nameEng,
          style: new TextStyle(
              fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        new Text(
          _nameChi,
          style: new TextStyle(fontSize: 12.0, color: Colors.grey),
        ),
      ],
    );
  }
}

class PriceColumn extends StatelessWidget {
  final String _mainPrice;

  final String _bottomPrice;
  final String _bottomPriceLabel;

  PriceColumn(this._mainPrice, this._bottomPrice, this._bottomPriceLabel);

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new MainPrice(_mainPrice),
        new Text(
          _bottomPriceLabel + ': ' + _bottomPrice,
          style: new TextStyle(
            color: Colors.black87,
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}

class MainPrice extends StatelessWidget {
  final String price;
  final SplitedPrice splited;
  final Color color;

  MainPrice(this.price)
      : splited = SplitedPrice(price),
        color = rng.nextInt(2) == 0 ? Colors.red : Colors.green;

  @override
  Widget build(BuildContext context) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            new Text(
              splited.prefix,
              style: new TextStyle(
                color: color,
                fontSize: 18.0,
              ),
            ),
            new Text(
              splited.middle,
              style: new TextStyle(
                color: color,
                fontSize: 28.0,
              ),
            ),
          ],
        ),
        new Container(
          child: new Text(
            splited.suffix,
            style: new TextStyle(
              color: color,
              fontSize: 18.0,
            ),
          ),
        )
      ],
    );
  }
}
