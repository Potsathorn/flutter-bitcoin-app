import 'package:bitcoin_app/domain/entities/price_data.dart';
import 'package:bitcoin_app/presentation/utils/app_color.dart';
import 'package:bitcoin_app/presentation/utils/app_text_style.dart';
import 'package:bitcoin_app/presentation/widgets/history_card.dart';
import 'package:flutter/material.dart';

class HistoryDrawer extends StatelessWidget {
  final List<PriceData> priceDataList;
  const HistoryDrawer({super.key, required this.priceDataList});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.history,
                    size: 80,
                    color: AppColors.white,
                  ),
                  Text(
                    'Price Update History',
                    style: AppTextStyles.headingWhite2,
                  ),
                ],
              ),
            ),
          ),
          priceDataList.isEmpty
              ? const Text(
                  "No Data!",
                  style: AppTextStyles.bodyTextSecondary,
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: priceDataList.length,
                      itemBuilder: (context, index) {
                        return HistoryCard(priceData: priceDataList[index]);
                      }),
                )
        ],
      ),
    );
  }
}
