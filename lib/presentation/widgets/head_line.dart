import 'package:bitcoin_app/presentation/utils/app_color.dart';
import 'package:bitcoin_app/presentation/utils/app_text_style.dart';
import 'package:flutter/cupertino.dart';

class HeadLine extends StatelessWidget {
  final String title;
  final double width;
  const HeadLine({super.key, required this.title, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondary,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Text(
        title,
        style: AppTextStyles.heading3,
      ),
    );
  }
}
