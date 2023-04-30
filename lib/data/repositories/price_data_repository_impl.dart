// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:bitcoin_app/data/datasources/remote_data_source.dart';
import 'package:bitcoin_app/data/exception.dart';
import 'package:bitcoin_app/data/failure.dart';
import 'package:bitcoin_app/domain/entities/price_data.dart';
import 'package:bitcoin_app/domain/repositories/price_data_repository.dart';

class PriceDataRepositoryImpl implements PriceDataRepository {
  final RemoteDataSource remoteDataSource;

  PriceDataRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, PriceData>> getPriceData() async {
    try {
      final result = await remoteDataSource.getPriceData();
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('Server failure'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
