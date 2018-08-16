import 'dart:math';

var random = Random();

enum Actions { Refresh }

class PricesState {
  final List<ContractPrice> contractPrices;

  PricesState({this.contractPrices});

  factory PricesState.initial() => PricesState(
        contractPrices: <ContractPrice>[
          ContractPrice.random(
            contractName: 'EURUSD',
            contractNameLocal: '歐元美元',
          ),
          ContractPrice.random(
            contractName: 'CADUSD',
            contractNameLocal: '加元美元',
          ),
          ContractPrice.random(
            contractName: 'AUDUSD',
            contractNameLocal: '澳元美元',
          ),
        ],
      );

  factory PricesState.randomTick(PricesState prev) {
    List<ContractPrice> newContractPrices = [];
    bool changed;

    for (ContractPrice p in prev.contractPrices) {
      changed = random.nextBool();

      if (changed) {
        newContractPrices.add(ContractPrice.nextTick(prev: p));
      } else {
        newContractPrices.add(p);
      }
    }

    return PricesState(contractPrices: newContractPrices);
  }
}

class ContractPrice {
  final String contractName, contractNameLocal;
  final double _bid, _high, _low;
  static const double basicMean = 1.0000;
  static const double floatMean = 0.5;
  static const double variance = 0.05;
  static const double spread = 0.0004;
  static const double tickDiffMean = 0.0003;
  static const int fixedDigits = 5;

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
    double bid = double.parse(prev.bid), high = double.parse(prev.high), low = double.parse(prev.low);

    bid = bid + diff;
    high = bid > high ? bid : high;
    low = bid < low ? bid : low;

    return ContractPrice(
      bid,
      high,
      low,
      contractName: prev.contractName,
      contractNameLocal: prev.contractNameLocal,
    );
  }
}

PricesState reducer(PricesState state, dynamic action) => PricesState.randomTick(state);
