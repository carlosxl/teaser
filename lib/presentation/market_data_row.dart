import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'package:my_project/models/market_data.dart';
import 'package:my_project/localizations.dart';


class MarketDataRow extends StatefulWidget {
  final MarketData data;

  MarketDataRow(this.data);

  _RowState createState() => _RowState(data);
}

class _RowState extends State<MarketDataRow> with SingleTickerProviderStateMixin {
  static final _nameTextStyle = TextStyle(
    fontSize: 18.0,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static final _nameLocalTextStyle = TextStyle(
    fontSize: 12.0,
    color: Colors.grey,
  );
  static final _highLowTextStyle = TextStyle(
    fontSize: 12.0,
    color: Colors.black,
  );

  Animation<Color> animation;
  AnimationController controller;

  final MarketData data;

  _RowState(this.data);

  Color get priceColor {
    switch (data.priceChange) {
      case PriceChange.Increased:
        return Colors.red;
      case PriceChange.Decreased:
        return Colors.green;
      case PriceChange.NotChanged:
        return Colors.grey;
    }
    return Colors.grey;
  }

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = ColorTween(begin: Colors.grey, end: Colors.red).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.name,
                    style: _nameTextStyle,
                  ),
                  Text(
                    data.nameLocal,
                    style: _nameLocalTextStyle,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  _ZoomedPrice(data.bid, data.digits, animation.value),
                  Text(
                    AppLocalizations.of(context).highPrice + data.low.toStringAsFixed(data.digits),
                    style: _highLowTextStyle,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  _ZoomedPrice(data.ask, data.digits, animation.value),
                  Text(
                    AppLocalizations.of(context).lowPrice + data.high.toStringAsFixed(data.digits),
                    style: _highLowTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _ZoomedPrice extends StatelessWidget {
  static final int zoomedDigits = 2;
  static final int tailDigits = 1;
  static final double fontSizeBasic = 18.0;
  static final double fontSizeZoomed = 28.0;

  // TODO: work on this.

  final double price;
  final int digits;
  final Color color;

  _ZoomedPrice(this.price, this.digits, this.color);

  String get priceStr {
    return price.toStringAsFixed(digits);
  }

  int get length {
    return priceStr.length;
  }

  String get head {
    return priceStr.substring(0, length - zoomedDigits - tailDigits);
  }

  String get zoomed {
    int startIdx = length - zoomedDigits - tailDigits;
    return priceStr.substring(startIdx, startIdx + zoomedDigits);
  }

  String get tail {
    int startIdx = length - tailDigits;
    return priceStr.substring(startIdx, startIdx + tailDigits);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            new Text(
              head,
              style: TextStyle(
                fontSize: fontSizeBasic,
                color: color,
              ),
            ),
            new Text(
              zoomed,
              style: TextStyle(
                fontSize: fontSizeZoomed,
                color: color,
              ),
            ),
          ],
        ),
        new Text(
          tail,
          style: TextStyle(
            fontSize: fontSizeBasic,
            color: color,
          ),
        ),
      ],
    );
  }
}
