import 'package:bitcoin_app/data/failure.dart';
import 'package:bitcoin_app/data/models/price_data_model.dart';
import 'package:bitcoin_app/domain/entities/price_data.dart';
import 'package:bitcoin_app/domain/usecase/get_price_data.dart';
import 'package:bitcoin_app/presentation/app_state/bitcoin_state/price_data_notifier.dart';
import 'package:bitcoin_app/presentation/app_state/bitcoin_state/price_data_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'price_data_notifier_test.mocks.dart';

@GenerateMocks([GetPriceData])
void main() {
  late MockGetPriceData mockGetPriceData;
  late PriceDataNotifier priceDataNotifier;
  setUp(() {
    mockGetPriceData = MockGetPriceData();
    priceDataNotifier = PriceDataNotifier(mockGetPriceData);
  });

  final tpriceData = PriceData(
    time: Time(
      updated: "Apr 30, 2023 11:36:00 UTC",
      updatedIso: DateTime.parse("2023-04-30T11:36:00+00:00"),
      updateduk: "Apr 30, 2023 at 12:36 BST",
    ),
    disclaimer:
        "This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org",
    chartName: "Bitcoin",
    bpi: Bpi(
      usd: Currency(
        code: "USD",
        symbol: "&#36;",
        rate: "29,270.6920",
        description: "United States Dollar",
        rateFloat: 29270.692,
      ),
      gbp: Currency(
        code: "GBP",
        symbol: "&pound;",
        rate: "24,458.3561",
        description: "British Pound Sterling",
        rateFloat: 24458.3561,
      ),
      eur: Currency(
        code: "EUR",
        symbol: "&euro;",
        rate: "28,513.9276",
        description: "Euro",
        rateFloat: 28513.9276,
      ),
    ),
  );

  test(
    'initial value should be as set and state should be empty',
    () {
      expect(priceDataNotifier.priceDataState, PriceDataEmpty());
      expect(priceDataNotifier.priceDataList.length, 0);
      expect(priceDataNotifier.bitcoinPrice, 0);
      expect(priceDataNotifier.selectedCurrency, 'USD');
    },
  );

  test(
      'should set priceDataState to PriceDataHasData when execution is successful ',
      () async {
    when(mockGetPriceData.execute()).thenAnswer((_) async => Right(tpriceData));
    await priceDataNotifier.getPriceData();
    expect(priceDataNotifier.priceDataState, PriceDataHasData(tpriceData));
  });

  test('should set priceDataState to PriceDataError when execution is Failure ',
      () async {
    when(mockGetPriceData.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server failure')));
    await priceDataNotifier.getPriceData();
    expect(priceDataNotifier.priceDataState,
        const PriceDataError('Server failure'));
  });

  test('should add new price data to the list', () {
    priceDataNotifier.addPriceData(tpriceData);
    expect(priceDataNotifier.priceDataList.length, 1);
    expect(priceDataNotifier.priceDataList[0], tpriceData);
  });

  test('should convert USD to BTC', () {
    const exchangeRate = 29270.692; // exchange rate as of April 30, 2023
    const currencyValue = 10000.0; // $10,000 USD
    priceDataNotifier.convertToBitcoin(currencyValue, exchangeRate);
    expect(priceDataNotifier.bitcoinPrice, currencyValue / exchangeRate);
  });

  test('should set selectedCurrency to GBP', () {
    priceDataNotifier.changeCurrency('GBP');
    expect(priceDataNotifier.selectedCurrency, 'GBP');
  });
}
