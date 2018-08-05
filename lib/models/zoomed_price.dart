/// Split a string price to 3 parts so that the middle part can be highlighted
/// in the UI. E.g., 1.11223 will be splited to (1.11, 22, 3).
/// Default to leave 1 digit `suffixLength` to the end and 2 digits
/// `midLength` in the middle.
class SplitedPrice {
  final String price;
  final int midLength;
  final int suffixLength;

  SplitedPrice(this.price, {this.midLength: 2, this.suffixLength: 1});

  String get prefix {
    return price.substring(0, price.length - midLength - suffixLength);
  }

  String get middle {
    int startIdx = price.length - midLength - suffixLength;
    return price.substring(startIdx , startIdx + midLength);
  }

  String get suffix {
    int startIdx = price.length - suffixLength; 
    return price.substring(startIdx, startIdx + suffixLength);
  }
}
