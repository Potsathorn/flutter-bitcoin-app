import 'package:bitcoin_app/data/models/price_data_model.dart';
import 'package:equatable/equatable.dart';

class PriceData extends Equatable {
  const PriceData({
    this.time,
    this.disclaimer,
    this.chartName,
    this.bpi,
  });

  final Time? time;
  final String? disclaimer;
  final String? chartName;
  final Bpi? bpi;

  @override
  List<Object?> get props => [
        time,
        disclaimer,
        chartName,
        bpi,
      ];
}
