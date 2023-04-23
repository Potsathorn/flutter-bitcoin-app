import 'package:bitcoin_app/data/failure.dart';
import 'package:bitcoin_app/domain/entities/price_data.dart';
import 'package:bitcoin_app/domain/repositories/price_data_repository.dart';
import 'package:dartz/dartz.dart';

class GetPriceData {
  final PriceDataRepository repository;

  GetPriceData(this.repository);

  Future<Either<Failure, PriceData>> execute() {
    return repository.getPriceData();
  }
}
