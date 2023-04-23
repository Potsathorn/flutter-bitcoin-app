import 'dart:convert';

import 'package:bitcoin_app/data/constans.dart';
import 'package:bitcoin_app/data/exception.dart';
import 'package:bitcoin_app/data/models/price_data_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<PriceDataModel> getPriceData();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  RemoteDataSourceImpl({required this.client});

  @override
  Future<PriceDataModel> getPriceData() async {
    final response = await client.get(Uri.parse(Config.baseUrl));

    if (response.statusCode == 200) {
      return PriceDataModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
