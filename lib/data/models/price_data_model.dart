import 'package:bitcoin_app/domain/entities/price_data.dart';
import 'package:equatable/equatable.dart';

class PriceDataModel extends Equatable {
  const PriceDataModel({
    this.time,
    this.disclaimer,
    this.chartName,
    this.bpi,
  });

  final Time? time;
  final String? disclaimer;
  final String? chartName;
  final Bpi? bpi;

  PriceDataModel copyWith({
    Time? time,
    String? disclaimer,
    String? chartName,
    Bpi? bpi,
  }) =>
      PriceDataModel(
        time: time ?? this.time,
        disclaimer: disclaimer ?? this.disclaimer,
        chartName: chartName ?? this.chartName,
        bpi: bpi ?? this.bpi,
      );

  factory PriceDataModel.fromJson(Map<String, dynamic> json) => PriceDataModel(
        time: json["time"] == null ? null : Time.fromJson(json["time"]),
        disclaimer: json["disclaimer"],
        chartName: json["chartName"],
        bpi: json["bpi"] == null ? null : Bpi.fromJson(json["bpi"]),
      );

  Map<String, dynamic> toJson() => {
        "time": time?.toJson(),
        "disclaimer": disclaimer,
        "chartName": chartName,
        "bpi": bpi?.toJson(),
      };

  PriceData toEntity() => PriceData(
        time: time,
        disclaimer: disclaimer,
        chartName: chartName,
        bpi: bpi,
      );

  @override
  List<Object?> get props => [
        time,
        disclaimer,
        chartName,
        bpi,
      ];
}

class Bpi {
  Bpi({
    this.usd,
    this.gbp,
    this.eur,
  });

  Currency? usd;
  Currency? gbp;
  Currency? eur;

  Bpi copyWith({
    Currency? usd,
    Currency? gbp,
    Currency? eur,
  }) =>
      Bpi(
        usd: usd ?? this.usd,
        gbp: gbp ?? this.gbp,
        eur: eur ?? this.eur,
      );

  factory Bpi.fromJson(Map<String, dynamic> json) => Bpi(
        usd: json["USD"] == null ? null : Currency.fromJson(json["USD"]),
        gbp: json["GBP"] == null ? null : Currency.fromJson(json["GBP"]),
        eur: json["EUR"] == null ? null : Currency.fromJson(json["EUR"]),
      );

  Map<String, dynamic> toJson() => {
        "USD": usd?.toJson(),
        "GBP": gbp?.toJson(),
        "EUR": eur?.toJson(),
      };
}

class Currency {
  Currency({
    this.code,
    this.symbol,
    this.rate,
    this.description,
    this.rateFloat,
  });

  String? code;
  String? symbol;
  String? rate;
  String? description;
  double? rateFloat;

  Currency copyWith({
    String? code,
    String? symbol,
    String? rate,
    String? description,
    double? rateFloat,
  }) =>
      Currency(
        code: code ?? this.code,
        symbol: symbol ?? this.symbol,
        rate: rate ?? this.rate,
        description: description ?? this.description,
        rateFloat: rateFloat ?? this.rateFloat,
      );

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        code: json["code"],
        symbol: json["symbol"],
        rate: json["rate"],
        description: json["description"],
        rateFloat: json["rate_float"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "symbol": symbol,
        "rate": rate,
        "description": description,
        "rate_float": rateFloat,
      };
}

class Time {
  Time({
    this.updated,
    this.updatedIso,
    this.updateduk,
  });

  String? updated;
  DateTime? updatedIso;
  String? updateduk;

  Time copyWith({
    String? updated,
    DateTime? updatedIso,
    String? updateduk,
  }) =>
      Time(
        updated: updated ?? this.updated,
        updatedIso: updatedIso ?? this.updatedIso,
        updateduk: updateduk ?? this.updateduk,
      );

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        updated: json["updated"],
        updatedIso: json["updatedISO"] == null
            ? null
            : DateTime.parse(json["updatedISO"]),
        updateduk: json["updateduk"],
      );

  Map<String, dynamic> toJson() => {
        "updated": updated,
        "updatedISO": updatedIso?.toIso8601String(),
        "updateduk": updateduk,
      };
}
