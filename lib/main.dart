import 'package:bitcoin_app/presentation/pages/fibonacci/fibonacci_page.dart';
import 'package:bitcoin_app/presentation/pages/filter_array/filter_array_page.dart';
import 'package:bitcoin_app/presentation/pages/prime_number/prime_number.dart';
import 'package:bitcoin_app/presentation/routes/routes.dart';
import 'package:bitcoin_app/presentation/pages/bitcoin/bitcoin_price_page.dart';
import 'package:bitcoin_app/presentation/pages/validate_pincode/validae_pincade.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'injection.dart' as di;
import 'presentation/app_state/bitcoin_state/price_data_notifier.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => di.locator<PriceDataNotifier>()),
      ],
      child: MaterialApp(
          title: 'My Awesome App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.bitcoin,
          routes: {
            Routes.bitcoin: (context) => const PriceDataScreen(),
            Routes.fibonacci: (context) => const FibonacciPage(),
            Routes.primeNumber: (context) => const PrimeNumberPage(),
            Routes.filterArray: (context) => const FilterArrayPage(),
            Routes.validatePincode: (context) => const ValidatePincodePage(),
          }),
    );
  }
}
