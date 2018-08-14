class PricesState {
  final List<ContractPrice> contractPrices;

  PricesState({this.contractPrices});

  factory PricesState.initial() => PricesState(
        contractPrices: <ContractPrice>[
          ContractPrice(
            contractName: 'EURUSD',
            bid: '1.22233',
            ask: '1.33322',
            high: '1.44444',
            low: '1.22222',
          ),
          ContractPrice(
            contractName: 'CADUSD',
            bid: '1.22233',
            ask: '1.33322',
            high: '1.44444',
            low: '1.22222',
          ),
          ContractPrice(
            contractName: 'AUDUSD',
            bid: '1.22233',
            ask: '1.33322',
            high: '1.44444',
            low: '1.22222',
          ),
        ],
      );
}

class ContractPrice {
  final String contractName, bid, ask, high, low;

  ContractPrice({
    this.contractName,
    this.bid = '0.000',
    this.ask = '0.000',
    this.high = '0.000',
    this.low = '0.000',
  });
}

PricesState reducer(PricesState state, dynamic action) => PricesState.initial();