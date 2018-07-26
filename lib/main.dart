import 'package:flutter/material.dart';
import 'dart:math';

var rng = new Random();

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.deepOrange,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('贵金属行情'),
        ),
        body: new ListView(
          children:
              new List<Widget>.generate(30, (int index) => new MarketDataRow()),
        ),
      ),
    );
  }
}

class MarketDataRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new ContractName('Gold', '伦敦金'),
        new PriceColumn(1266.102, 1255.222, '最低价'),
        new PriceColumn(1266.532, 1275.232, '最高价'),
      ],
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
          style: new TextStyle(fontSize: 14.0, color: Colors.grey),
        ),
      ],
    );
  }
}

class PriceColumn extends StatelessWidget {
  final double _mainPrice;
  final Color _mainPriceColor;

  final double _bottomPrice;
  final String _bottomPriceLabel;

  PriceColumn(this._mainPrice, this._bottomPrice, this._bottomPriceLabel)
      : _mainPriceColor = rng.nextInt(2) == 0 ? Colors.red : Colors.green,
        super();

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Text(
          _mainPrice.toString(),
          style: new TextStyle(color: _mainPriceColor, fontSize: 28.0),
        ),
        new Text(
          _bottomPriceLabel + ': ' + _bottomPrice.toString(),
          style: new TextStyle(color: Colors.black87),
        ),
      ],
    );
  }
}
