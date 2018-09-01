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
  final bool isVisible;

  MarketData(
    this.name,
    this.nameLocal, {
    bid,
    ask,
    high,
    low,
    this.digits = 5,
    this.priceChange = PriceChange.NotChanged,
    this.isVisible = true,
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
      isVisible: prev.isVisible,
    );
  }

  MarketData copyWith({
    double bid,
    double ask,
    double high,
    double low,
    int digits,
    PriceChange priceChange,
    bool isVisible,
  }) {
    return MarketData(
      this.name,
      this.nameLocal,
      bid: bid ?? this.bid,
      ask: ask ?? this.ask,
      high: high ?? this.high,
      low: low ?? this.low,
      digits: digits ?? this.digits,
      priceChange: priceChange ?? this.priceChange,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}
