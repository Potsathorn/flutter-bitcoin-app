import 'dart:math';

import 'package:bitcoin_app/presentation/utils/app_color.dart';
import 'package:bitcoin_app/presentation/utils/app_text_style.dart';
import 'package:bitcoin_app/presentation/widgets/drawer.dart';
import 'package:flutter/material.dart';

class FilterArrayPage extends StatefulWidget {
  const FilterArrayPage({super.key});

  @override
  State<FilterArrayPage> createState() => _FilterArrayPageState();
}

class _FilterArrayPageState extends State<FilterArrayPage> {
  final TextEditingController _inputController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<int> _arr1 = [];
  List<int> _arr2 = [];
  List<int> _arrResult = [];

  @override
  void initState() {
    _arr1 = generateRandomNumbers();
    _arr2 = generateRandomNumbers();
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  List<int> generateRandomNumbers() {
    List<int> numbers = [];

    for (int i = 0; i < 5; i++) {
      int randomNum = Random().nextInt(11);
      numbers.add(randomNum);
    }

    return numbers;
  }

  List<int> filterArray(List<int> arr1, List<int> arr2) {
    List<int> result = [];

    for (int i = 0; i < arr1.length; i++) {
      for (int j = 0; j < arr2.length; j++) {
        if (arr1[i] == arr2[j]) {
          result.add(arr1[i]);
          break;
        }
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Center(child: Text('Filter Array')),
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
            iconSize: 30,
          );
        }),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              display(_arr1, "Array 1"),
              display(_arr2, "Array 2"),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    _arr1 = generateRandomNumbers();
                    _arr2 = generateRandomNumbers();
                    _arrResult.clear;
                    setState(() {});
                  },
                  child: const Text('Random'),
                ),
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    _arrResult = filterArray(_arr1, _arr2);
                    setState(() {});
                  },
                  child: const Text('Filter'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              display(_arrResult, "Result"),
            ],
          ),
        ),
      ),
    );
  }

  Widget display(List<int> arr, String name) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: AppTextStyles.bodyTextSecondary),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: MediaQuery.of(context).size.width,
            constraints: const BoxConstraints(
              minHeight: 50,
            ),
            color: AppColors.primary,
            padding: const EdgeInsets.all(12),
            child: Text(
              arr.isEmpty ? "-- No Data --" : arr.join(", "),
              style: AppTextStyles.bodyText,
            ),
          ),
        ],
      );
}
