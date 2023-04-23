import 'package:bitcoin_app/presentation/utils/app_color.dart';
import 'package:flutter/material.dart';

class CurrencyUtils {
  static const _currencySymbols = {
    'USD': '\$',
    'EUR': '€',
    'GBP': '£',
    'BTC': '₿'
  };

  static const _currencyColor = {
    'USD': AppColors.usd,
    'EUR': AppColors.eur,
    'GBP': AppColors.gbp,
    'BTC': AppColors.btc
  };

  static String getCurrencySymbol(String currencyCode) {
    return _currencySymbols[currencyCode.toUpperCase()] ?? '';
  }

  static Color getCurrencyColor(String currencyCode) {
    return _currencyColor[currencyCode.toUpperCase()] ?? AppColors.primary;
  }
}
