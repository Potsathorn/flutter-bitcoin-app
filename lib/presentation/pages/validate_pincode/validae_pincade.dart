import 'package:bitcoin_app/presentation/utils/app_color.dart';
import 'package:bitcoin_app/presentation/utils/helper.dart';
import 'package:bitcoin_app/presentation/widgets/circle_icon.dart';
import 'package:bitcoin_app/presentation/widgets/drawer.dart';
import 'package:flutter/material.dart';

class ValidatePincodePage extends StatefulWidget {
  const ValidatePincodePage({super.key});

  @override
  State<ValidatePincodePage> createState() => _ValidatePincodePageState();
}

class _ValidatePincodePageState extends State<ValidatePincodePage> {
  final TextEditingController _inputController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _showIcon = false;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Center(child: Text('Validate Pincode')),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 110,
                child: _showIcon
                    ? CircleIcon(
                        icon: _isValid ? Icons.check : Icons.close,
                        description: _isValid ? "Success" : "Failure",
                        color: _isValid ? AppColors.success : AppColors.fail,
                        colorDescription:
                            _isValid ? AppColors.success : AppColors.fail,
                      )
                    : null,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _inputController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    fillColor: Colors.white,
                    hintText: 'Enter Pincode',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _showIcon = false;
                    setState(() {});
                  },
                  validator: (value) {
                    _isValid = Helper.validatePincode(value).keys.first;
                    if (!_isValid) {
                      return Helper.validatePincode(value).values.first;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _showIcon = true;
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                  setState(() {});

                  // Perform validation logic here
                },
                child: const Text('Validate'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
