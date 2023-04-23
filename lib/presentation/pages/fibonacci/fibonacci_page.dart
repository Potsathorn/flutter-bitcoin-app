import 'package:bitcoin_app/presentation/utils/app_color.dart';
import 'package:bitcoin_app/presentation/utils/app_text_style.dart';
import 'package:bitcoin_app/presentation/utils/helper.dart';
import 'package:bitcoin_app/presentation/widgets/drawer.dart';
import 'package:flutter/material.dart';

class FibonacciPage extends StatefulWidget {
  const FibonacciPage({super.key});

  @override
  State<FibonacciPage> createState() => _FibonacciPageState();
}

class _FibonacciPageState extends State<FibonacciPage> {
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

  List<int> generateFibonacci(int n) {
    List<int> fibonacciList = [0, 1];

    if (n == 0) {
      return [0];
    }
    if (n == 1) {
      return fibonacciList;
    }

    for (int i = 2; i <= n; i++) {
      int nextFibonacci = fibonacciList[i - 1] + fibonacciList[i - 2];
      fibonacciList.add(nextFibonacci);
    }
    return fibonacciList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Center(child: Text('Fibonacci Generate')),
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
                    hintText: 'Enter term number "n"',
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
                        generateFibonacci(int.parse(_inputController.text));
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
                      'Fibonacci Sequence:',
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
