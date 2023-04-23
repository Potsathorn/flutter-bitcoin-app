import 'package:bitcoin_app/data/failure.dart';
import 'package:bitcoin_app/domain/entities/price_data.dart';
import 'package:dartz/dartz.dart';

abstract class PriceDataRepository {
  Future<Either<Failure, PriceData>> getPriceData();
}
