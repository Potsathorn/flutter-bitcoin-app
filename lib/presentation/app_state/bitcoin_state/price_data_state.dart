import 'package:bitcoin_app/domain/entities/price_data.dart';
import 'package:equatable/equatable.dart';

abstract class PriceDataState extends Equatable {
  const PriceDataState();
  @override
  List<Object?> get props => [];
}

class PriceDataEmpty extends PriceDataState {}

class PriceDataLoading extends PriceDataState {}

class PriceDataError extends PriceDataState {
  final String message;
  const PriceDataError(this.message);

  @override
  List<Object?> get props => [message];
}

class PriceDataHasData extends PriceDataState {
  final PriceData data;
  const PriceDataHasData(this.data);

  @override
  List<Object?> get props => [data];
}
