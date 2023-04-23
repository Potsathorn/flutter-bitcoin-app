import 'package:bitcoin_app/presentation/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String symbol;
  final String code;
  final String description;
  final String rate;
  final Color color;

  const CurrencyCard(
      {super.key,
      required this.symbol,
      required this.code,
      required this.description,
      required this.rate,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text(
            symbol,
            style: AppTextStyles.headingWhite1,
          ),
        ),
        title: Text(code, style: AppTextStyles.heading3),
        subtitle: Text(description),
        trailing: Text(rate, style: AppTextStyles.heading2),
      ),
    );
  }
}
