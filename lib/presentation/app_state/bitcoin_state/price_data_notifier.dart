import 'dart:developer';

import 'package:bitcoin_app/domain/entities/price_data.dart';
import 'package:bitcoin_app/presentation/app_state/bitcoin_state/price_data_state.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_app/domain/usecase/get_price_data.dart';

class PriceDataNotifier with ChangeNotifier {
  final GetPriceData _getCurrentPriceData;

  PriceDataState _priceDataState = PriceDataEmpty();
  double _bitcoinPrice = 0;
  String _selectedCurrency = "USD";
  // ignore: prefer_final_fields
  List<PriceData> _priceDataList = [];

  List<String> currencyList = [
    'USD',
    'GBP',
    'EUR',
  ];

  PriceDataNotifier(this._getCurrentPriceData);

  PriceDataState get priceDataState => _priceDataState;
  double get bitcoinPrice => _bitcoinPrice;
  String get selectedCurrency => _selectedCurrency;
  List<PriceData> get priceDataList => _priceDataList;

  void addPriceData(PriceData priceData) {
    _priceDataList.add(priceData);
    notifyListeners();
  }

  void convertToBitcoin(double currencyValue, double exchangeRate) {
    _bitcoinPrice = currencyValue / exchangeRate;
    notifyListeners();
  }

  void changeCurrency(String currency) {
    _selectedCurrency = currency;
    notifyListeners();
  }

  Future<void> getPriceData() async {
    log("update");
    _priceDataState = PriceDataLoading();
    //notifyListeners();
    await _getCurrentPriceData
        .execute()
        .then((result) => result.fold((failure) {
              _priceDataState = PriceDataError(failure.message);
              notifyListeners();
            }, (data) {
              _priceDataState = PriceDataHasData(data);
              notifyListeners();
            }));
  }
}
