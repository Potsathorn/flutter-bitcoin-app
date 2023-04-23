import 'package:bitcoin_app/presentation/utils/app_color.dart';
import 'package:bitcoin_app/presentation/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  final double height;
  final double width;
  final String symbol;
  final String currency;
  final String? updateTime;
  final Color color;

  const AppBanner({
    super.key,
    required this.height,
    required this.width,
    required this.symbol,
    required this.currency,
    required this.color,
    this.updateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.btc,
            child: Text(
              symbol,
              style: AppTextStyles.headingWhite1,
            ),
          ),
          Text(
            currency,
            style: AppTextStyles.heading2,
          ),
          Text(
            "Updeted : ${updateTime ?? '-'}",
            style: AppTextStyles.bodyText,
          ),
        ],
      ),
    );
  }
}
