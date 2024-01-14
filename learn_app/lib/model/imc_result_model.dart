import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'imc_result_model.g.dart';

@HiveType(typeId: 2)
class ImcResultModel extends HiveObject {
  @HiveField(0)
  final String id = UniqueKey().toString();

  @HiveField(1)
  double? weight;

  @HiveField(2)
  double? height;

  @HiveField(3)
  double? imc;

  @HiveField(4)
  DateTime? date;

  ImcResultModel(
      {required this.weight,
      required this.height,
      required this.imc,
      required this.date});
}
