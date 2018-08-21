import 'dart:async';
import 'dart:math';

import 'package:flutter/animation.dart';
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
    new Timer(const Duration(milliseconds: 1500), () {
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
              title: new Text('外汇行情'),
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
    return new StoreConnector<PricesState, Map<String, ContractPrice>>(
        converter: (store) => store.state.contractPrices,
        builder: (BuildContext context, Map<String, ContractPrice> contractPrices) {
          return new ListView(
            children: contractPrices
                .map((k, contractPrice) =>
                    MapEntry(k, MarketDataRow(contractPrice)))
                .values
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
            child: new PriceColumn(contractPrice, '最低价'),
          ),
          new Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: new PriceColumn(contractPrice, '最高价'),
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
  final ContractPrice _contractPrice;

  final String _mainPrice;
  final String _bottomPrice;
  final String _bottomPriceLabel;

  PriceColumn(this._contractPrice, this._bottomPriceLabel, {Key key})
      : _mainPrice = _bottomPriceLabel == '最低价'
            ? _contractPrice.bid
            : _contractPrice.ask,
        _bottomPrice = _bottomPriceLabel == '最低价'
            ? _contractPrice.low
            : _contractPrice.high,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new MainPrice(_contractPrice, SplitedPrice(_mainPrice)),
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

class MainPrice extends StatefulWidget {
  final ContractPrice contractPrice;
  final SplitedPrice splited;

  MainPrice(this.contractPrice, this.splited, {Key key}) : super(key: key);

  _MainPriceState createState() => _MainPriceState(contractPrice, splited);
}

class _MainPriceState extends State<MainPrice> with SingleTickerProviderStateMixin {
  final ContractPrice contractPrice;
  final SplitedPrice splited;

  AnimationController controller;
  Animation<Color> animation;

  initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 100), vsync: this,
    );
    animation = ColorTween(begin: Colors.red, end: Colors.green).animate(controller);
    controller.forward();
  }

  _MainPriceState(this.contractPrice, this.splited);

  @override
  Widget build(BuildContext context) {
    return AnimatedPrice(splited, animation: animation);
  }
}

class AnimatedPrice extends AnimatedWidget {
  final SplitedPrice splited;

  AnimatedPrice(this.splited, {Key key, Animation animation}) : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<Color> animation = listenable;
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
                color: animation.value,
                fontSize: 18.0,
              ),
            ),
            new Text(
              splited.middle,
              style: new TextStyle(
                color: animation.value,
                fontSize: 28.0,
              ),
            ),
          ],
        ),
        new Container(
          child: new Text(
            splited.suffix,
            style: new TextStyle(
              color: animation.value,
              fontSize: 18.0,
            ),
          ),
        )
      ],
    );
  }
}