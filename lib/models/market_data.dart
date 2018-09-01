import 'dart:math';

import 'package:meta/meta.dart';

enum PriceChange { Increased, Decreased, NotChanged }

@immutable
class MarketData {
  final String name;
  final String nameLocal;
  final double bid;
  final double ask;
  final double high;
  final double low;
  final int digits;
  final PriceChange priceChange;

  MarketData(
    this.name,
    this.nameLocal, {
    bid,
    ask,
    high,
    low,
    this.digits = 5,
    this.priceChange = PriceChange.NotChanged,
  })  : this.bid = bid ?? pow(10, 5 - digits).toDouble(),
        this.ask = ask ?? pow(10, 5 - digits).toDouble(),
        this.high = high ?? pow(10, 5 - digits).toDouble(),
        this.low = low ?? pow(10, 5 - digits).toDouble();

  factory MarketData.fromPrev(MarketData prev, double ratio) {
    PriceChange priceChange = ratio == 1
        ? PriceChange.NotChanged
        : ratio > 1 ? PriceChange.Increased : PriceChange.Decreased;

    return MarketData(
      prev.name,
      prev.nameLocal,
      bid: prev.bid * ratio,
      ask: prev.ask * ratio,
      high: (prev.ask * ratio) > prev.high ? prev.ask * ratio : prev.high,
      low: (prev.bid * ratio) < prev.high ? prev.bid * ratio : prev.low,
      digits: prev.digits,
      priceChange: priceChange,
    );
  }
}
