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
    this.bid = 0.0,
    this.ask = 0.0,
    this.high = 0.0,
    this.low = 0.0,
    this.digits = 5,
    this.priceChange = PriceChange.NotChanged,
  });
}
