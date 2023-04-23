import 'package:bitcoin_app/presentation/utils/app_color.dart';
import 'package:bitcoin_app/presentation/utils/app_text_style.dart';
import 'package:bitcoin_app/presentation/utils/helper.dart';
import 'package:bitcoin_app/presentation/widgets/drawer.dart';
import 'package:flutter/material.dart';

class PrimeNumberPage extends StatefulWidget {
  const PrimeNumberPage({super.key});

  @override
  State<PrimeNumberPage> createState() => _PrimeNumberPageState();
}

class _PrimeNumberPageState extends State<PrimeNumberPage> {
  final TextEditingController _inputController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  List<int> _fibonacciList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  List<int> generatePrimes(int limit) {
    List<int> primes = [];

    for (int number = 2; number <= limit; number++) {
      bool isPrime = true;
      for (int i = 2; i <= number / 2; i++) {
        if (number % i == 0) {
          isPrime = false;
          break;
        }
      }
      if (isPrime) {
        primes.add(number);
      }
    }

    return primes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Center(child: Text('Prime Number Generate')),
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
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _inputController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    fillColor: Colors.white,
                    hintText: 'Enter limit',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => Helper.intergerValidator(value),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _fibonacciList =
                        generatePrimes(int.parse(_inputController.text));
                  }
                  setState(() {});
                },
                child: const Text('Generate'),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                constraints: const BoxConstraints(
                  minHeight: 200,
                ),
                color: AppColors.primary,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Prime Number:',
                      style: AppTextStyles.heading3,
                    ),
                    Text(
                      _fibonacciList.isEmpty ? "" : _fibonacciList.join(", "),
                      style: AppTextStyles.bodyText,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
