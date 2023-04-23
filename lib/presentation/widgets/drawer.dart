import 'package:bitcoin_app/presentation/routes/routes.dart';
import 'package:bitcoin_app/presentation/utils/app_color.dart';
import 'package:bitcoin_app/presentation/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
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
                    Icons.app_shortcut,
                    color: AppColors.white,
                    size: 40,
                  ),
                  Text(
                    "My Awesome App",
                    style: AppTextStyles.headingWhite2,
                  ),
                ],
              ),
            ),
          ),
          _drawerChilde(
              title: "Bitcoin Price",
              onTap: () => Navigator.pushNamed(context, Routes.bitcoin)),
          _drawerChilde(
              title: "Fibonacci",
              onTap: () => Navigator.pushNamed(context, Routes.fibonacci)),
          _drawerChilde(
              title: "Prime Number",
              onTap: () => Navigator.pushNamed(context, Routes.primeNumber)),
          _drawerChilde(
              title: "Filter Array",
              onTap: () => Navigator.pushNamed(context, Routes.filterArray)),
          _drawerChilde(
              title: "Validate Pincode",
              onTap: () =>
                  Navigator.pushNamed(context, Routes.validatePincode)),
        ],
      ),
    );
  }

  Widget _drawerChilde({required String title, void Function()? onTap}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: AppTextStyles.bodyText,
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
