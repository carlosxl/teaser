import 'dart:math';

var random = Random();

enum Actions { Refresh }
enum TickDiff { Increased, Decreased, NotChanged }

const contracts = [
  ['EURUSD', '歐元美元'],
  ['CADUSD', '加元美元'],
  ['AUDUSD', '澳元美元'],
];

class PricesState {
  final Map<String, ContractPrice> contractPrices;
  final Map<String, ContractPrice> prevContractPrices;

  PricesState({this.contractPrices, this.prevContractPrices});

  factory PricesState.initial() {
    Map<String, ContractPrice> _contractPrices = {};
    for (List<String> pair in contracts) {
      _contractPrices[pair[0]] = ContractPrice.random(
        contractName: pair[0],
        contractNameLocal: pair[1],
      );
    }
    return PricesState(contractPrices: _contractPrices);
  }

  factory PricesState.randomTick(PricesState prev) {
    Map<String, ContractPrice> newContractPrices = {};
    bool changed;

    prev.contractPrices.forEach((k, v) {
      changed = random.nextBool();

      if (changed) {
        newContractPrices[k] = ContractPrice.nextTick(prev: v);
      } else {
        newContractPrices[k] = ContractPrice.copy(prev: v);
      }
    });

    return PricesState(
      contractPrices: newContractPrices,
      prevContractPrices: prev.contractPrices,
    );
  }
}

class ContractPrice {
  static const double basicMean = 1.0000;
  static const double floatMean = 0.5;
  static const double variance = 0.05;
  static const double spread = 0.0004;
  static const double tickDiffMean = 0.0003;
  static const int fixedDigits = 5;

  final String contractName, contractNameLocal;
  final double _bid, _high, _low;
  final TickDiff tickDiff;

  get bid => _bid.toStringAsFixed(5);
  get ask => (_bid + spread).toStringAsFixed(fixedDigits);
  get high => _high.toStringAsFixed(5);
  get low => _low.toStringAsFixed(5);

  ContractPrice(
    this._bid,
    this._high,
    this._low, {
    this.contractName,
    this.contractNameLocal,
    this.tickDiff = TickDiff.NotChanged,
  });

  factory ContractPrice.random(
      {String contractName, String contractNameLocal}) {
    double bid, high, low;
    double mean = random.nextDouble() * floatMean + basicMean;

    bid = mean - variance * random.nextDouble();
    high = bid + variance * random.nextDouble();
    low = bid - variance * random.nextDouble();

    return ContractPrice(
      bid,
      high,
      low,
      contractName: contractName,
      contractNameLocal: contractNameLocal,
    );
  }

  factory ContractPrice.nextTick({ContractPrice prev}) {
    double diff = tickDiffMean * (random.nextDouble() - 0.5);
    double bid = double.parse(prev.bid),
        high = double.parse(prev.high),
        low = double.parse(prev.low);

    bid = bid + diff;
    high = bid > high ? bid : high;
    low = bid < low ? bid : low;

    return ContractPrice(
      bid,
      high,
      low,
      contractName: prev.contractName,
      contractNameLocal: prev.contractNameLocal,
      tickDiff: diff > 0
          ? TickDiff.Increased
          : (diff == 0 ? TickDiff.NotChanged : TickDiff.Decreased),
    );
  }

  factory ContractPrice.copy({ContractPrice prev}) {
    double bid = double.parse(prev.bid),
        high = double.parse(prev.high),
        low = double.parse(prev.low);

    return ContractPrice(
      bid,
      high,
      low,
      contractName: prev.contractName,
      contractNameLocal: prev.contractNameLocal,
    );
  }
}

PricesState reducer(PricesState state, dynamic action) =>
    PricesState.randomTick(state);
