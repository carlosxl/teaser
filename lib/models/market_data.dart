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
    this.bid = 1.0,
    this.ask = 1.0,
    this.high = 1.0,
    this.low = 1.0,
    this.digits = 5,
    this.priceChange = PriceChange.NotChanged,
  });

  factory MarketData.fromPrev(MarketData prev, double diff) {
    PriceChange priceChange = diff == 0
            ? PriceChange.NotChanged
            : diff > 0 ? PriceChange.Increased : PriceChange.Decreased;

    return MarketData(
      prev.name,
      prev.nameLocal,
      bid: prev.bid + diff,
      ask: prev.ask + diff,
      high: (prev.ask + diff) > prev.high ? prev.ask + diff : prev.high,
      low: (prev.bid + diff) < prev.high ? prev.bid + diff : prev.low,
      priceChange: priceChange,
    );
  }
}
