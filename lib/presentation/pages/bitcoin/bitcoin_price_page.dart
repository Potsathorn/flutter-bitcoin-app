import 'dart:async';
import 'package:bitcoin_app/presentation/app_state/bitcoin_state/price_data_notifier.dart';
import 'package:bitcoin_app/presentation/app_state/bitcoin_state/price_data_state.dart';
import 'package:bitcoin_app/presentation/utils/app_color.dart';
import 'package:bitcoin_app/presentation/utils/app_text_style.dart';
import 'package:bitcoin_app/presentation/utils/helper.dart';
import 'package:bitcoin_app/presentation/utils/currency.dart';
import 'package:bitcoin_app/presentation/widgets/banner.dart';
import 'package:bitcoin_app/presentation/widgets/currency_card.dart';
import 'package:bitcoin_app/presentation/widgets/drawer.dart';
import 'package:bitcoin_app/presentation/widgets/head_line.dart';
import 'package:bitcoin_app/presentation/widgets/history_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PriceDataScreen extends StatefulWidget {
  const PriceDataScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PriceDataScreenState();
}

class _PriceDataScreenState extends State<PriceDataScreen> {
  late Timer _timer;
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    final priceDataNotifier =
        Provider.of<PriceDataNotifier>(context, listen: false);
    priceDataNotifier.getPriceData();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      priceDataNotifier.getPriceData().then((value) {
        if (priceDataNotifier.priceDataState is PriceDataHasData) {
          final dataState =
              priceDataNotifier.priceDataState as PriceDataHasData;
          priceDataNotifier.addPriceData(dataState.data);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final priceDataNotifier = Provider.of<PriceDataNotifier>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Center(child: Text('Bitcoin Price')),
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
            iconSize: 30,
          );
        }),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.history),
              iconSize: 30,
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          }),
        ],
      ),
      drawer: const AppDrawer(),
      endDrawer: HistoryDrawer(
        priceDataList: priceDataNotifier.priceDataList.reversed.toList(),
      ),
      body: SingleChildScrollView(child: () {
        if (priceDataNotifier.priceDataState is PriceDataHasData) {
          final dataState =
              priceDataNotifier.priceDataState as PriceDataHasData;
          final usdData = dataState.data.bpi?.usd;
          final gbpData = dataState.data.bpi?.gbp;
          final eurData = dataState.data.bpi?.eur;
          final updated =
              Helper.getLocalTimeString(dataState.data.time?.updated ?? "");

          return Column(
            children: [
              AppBanner(
                height: 150,
                width: screenWidth,
                symbol: CurrencyUtils.getCurrencySymbol('BTC'),
                currency: 'Bitcoin (BTC)',
                color: AppColors.primary,
                updateTime: updated,
              ),
              HeadLine(
                title: "Currency",
                width: screenWidth,
              ),
              CurrencyCard(
                color: CurrencyUtils.getCurrencyColor(usdData?.code ?? ""),
                symbol: CurrencyUtils.getCurrencySymbol(usdData?.code ?? ""),
                code: usdData?.code ?? "",
                description: usdData?.description ?? "",
                rate: Helper.twoDecimalPlaces(usdData?.rateFloat ?? 0),
              ),
              CurrencyCard(
                color: CurrencyUtils.getCurrencyColor(gbpData?.code ?? ""),
                symbol: CurrencyUtils.getCurrencySymbol(gbpData?.code ?? ""),
                code: gbpData?.code ?? "",
                description: gbpData?.description ?? "",
                rate: Helper.twoDecimalPlaces(gbpData?.rateFloat ?? 0),
              ),
              CurrencyCard(
                color: CurrencyUtils.getCurrencyColor(eurData?.code ?? ""),
                symbol: CurrencyUtils.getCurrencySymbol(eurData?.code ?? ""),
                code: eurData?.code ?? "",
                description: eurData?.description ?? "",
                rate: Helper.twoDecimalPlaces(eurData?.rateFloat ?? 0),
              ),
              HeadLine(
                title: "Converter",
                width: screenWidth,
              ),
              Form(
                key: _formKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            fillColor: Colors.white,
                            hintText: 'Enter amount',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            return Helper.numberValidator(value);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: priceDataNotifier.selectedCurrency,
                        onChanged: (value) {
                          priceDataNotifier.changeCurrency(value ?? "");
                        },
                        items: priceDataNotifier.currencyList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                                color: CurrencyUtils.getCurrencyColor(value),
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  "${CurrencyUtils.getCurrencySymbol(value)} $value",
                                  style: AppTextStyles.heading3,
                                )),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    switch (priceDataNotifier.selectedCurrency.toUpperCase()) {
                      case 'USD':
                        priceDataNotifier.convertToBitcoin(
                            double.parse(_amountController.text),
                            usdData?.rateFloat ?? 0);
                        break;
                      case 'GBP':
                        priceDataNotifier.convertToBitcoin(
                            double.parse(_amountController.text),
                            gbpData?.rateFloat ?? 0);
                        break;
                      case 'EUR':
                        priceDataNotifier.convertToBitcoin(
                            double.parse(_amountController.text),
                            eurData?.rateFloat ?? 0);
                        break;
                      default:
                        return;
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.accent),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text(
                  'Convert',
                  style: AppTextStyles.heading3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "${Helper.fourDecimalPlaces(priceDataNotifier.bitcoinPrice)} ${CurrencyUtils.getCurrencySymbol("BTC")}",
                  style: AppTextStyles.heading,
                ),
              )
            ],
          );
        } else if (priceDataNotifier.priceDataState is PriceDataLoading) {
          return const Center(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          ));
        } else if (priceDataNotifier.priceDataState is PriceDataError) {
          final errorState = priceDataNotifier.priceDataState as PriceDataError;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                errorState.message,
                style: AppTextStyles.heading2,
              ),
            ),
          );
        } else if (priceDataNotifier.priceDataState is PriceDataEmpty) {
          return const Center(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "No data",
              style: AppTextStyles.heading2,
            ),
          ));
        } else {
          return const Center(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Something went wrong',
              style: AppTextStyles.heading2,
            ),
          ));
        }
      }()),
    );
  }
}
