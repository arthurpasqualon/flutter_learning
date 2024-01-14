import 'package:hive/hive.dart';
import 'package:learn_app/model/imc_result_model.dart';

class ImcResultsRepository {
  static late Box _box;

  // ignore: constant_identifier_names
  static const IMC_RESULTS_KEY = 'imc_results';

  ImcResultsRepository._create();
  static Future<ImcResultsRepository> load() async {
    if (Hive.isBoxOpen(IMC_RESULTS_KEY)) {
      _box = Hive.box(IMC_RESULTS_KEY);
    } else {
      _box = await Hive.openBox(IMC_RESULTS_KEY);
    }
    return ImcResultsRepository._create();
  }

  void save(ImcResultModel result) {
    _box.add(result);
  }

  void delete(ImcResultModel result) {
    result.delete();
  }

  List<ImcResultModel> fetchResults() {
    return _box.values.cast<ImcResultModel>().toList();
  }
}
