import 'package:flutter/material.dart';
import 'package:learn_app/model/imc_result_model.dart';
import 'package:learn_app/repositories/imc_results_repository.dart';
import 'package:learn_app/services/imc_calculator_service.dart';

class ImcCalcPage extends StatefulWidget {
  const ImcCalcPage({super.key});

  @override
  State<ImcCalcPage> createState() => _ImcCalcPageState();
}

class _ImcCalcPageState extends State<ImcCalcPage> {
  late ImcResultsRepository imcResultsRepository;

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  List<ImcResultModel> _results = <ImcResultModel>[];

  @override
  void initState() {
    super.initState();
    loadResults();
  }

  void loadResults() async {
    imcResultsRepository = await ImcResultsRepository.load();
    _results = imcResultsRepository.fetchResults();
    setState(() {});
  }

  void onSaveData() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text);
    double imc = ImcCalculatorService.calculateImc(weight, height);
    imcResultsRepository.save(ImcResultModel(
        weight: weight, height: height, imc: imc, date: DateTime.now()));
    loadResults();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IMC Calculator"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          weightController.clear();
          heightController.clear();
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("Add your data"),
                    content: SizedBox(
                      height: 250,
                      child: Column(
                        children: [
                          TextField(
                            controller: weightController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Weight",
                              hintText: "Enter Weight",
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: heightController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Height",
                              hintText: "Enter Height",
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: onSaveData,
                        child: const Text("Insert Data"),
                      ),
                    ],
                  ));
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (BuildContext context, int index) {
                  var result = _results[index];
                  return Dismissible(
                    key: Key(result.id.toString()),
                    onDismissed: (direction) async {
                      imcResultsRepository.delete(result);
                      loadResults();
                    },
                    child: ListTile(
                      title: Text(
                          "IMC: ${result.imc} - ${ImcCalculatorService.resultImcText(result.imc!)}"),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
