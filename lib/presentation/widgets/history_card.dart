import 'package:bitcoin_app/domain/entities/price_data.dart';
import 'package:bitcoin_app/presentation/utils/app_text_style.dart';
import 'package:bitcoin_app/presentation/utils/currency.dart';
import 'package:bitcoin_app/presentation/utils/helper.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final PriceData priceData;

  const HistoryCard({super.key, required this.priceData});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            Helper.getLocalTimeString(priceData.time?.updated ?? ""),
            style: AppTextStyles.bodyTextSecondary,
          ),
        ),
        _childCard(
            code: priceData.bpi?.usd?.code ?? "",
            rate: priceData.bpi?.usd?.rateFloat ?? 0),
        _childCard(
            code: priceData.bpi?.gbp?.code ?? "",
            rate: priceData.bpi?.gbp?.rateFloat ?? 0),
        _childCard(
            code: priceData.bpi?.eur?.code ?? "",
            rate: priceData.bpi?.eur?.rateFloat ?? 0),
        const Divider(
          thickness: 1,
        )
      ]),
    );
  }

  Widget _childCard({required String code, required double rate}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            code,
            style: AppTextStyles.bodyText,
          ),
          Text(
            "${CurrencyUtils.getCurrencySymbol(code)} ${Helper.twoDecimalPlaces(rate)}",
            style: AppTextStyles.bodyText,
          )
        ],
      );
}
