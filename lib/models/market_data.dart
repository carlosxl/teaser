import 'package:meta/meta.dart';


@immutable
class MarketData {
  final String name;
  final String nameLocal;
  final double bid;
  final double ask;
  final double high;
  final double low;
  final int digits;

  MarketData(
    this.name,
    this.nameLocal,
    this.bid,
    this.ask, {
    this.high = 0.0,
    this.low = 0.0,
    this.digits = 5,
  });
}
