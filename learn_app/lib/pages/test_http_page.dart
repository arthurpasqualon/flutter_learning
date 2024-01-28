import 'package:flutter/material.dart';
import 'package:learn_app/model/via_cep_model.dart';
import 'package:learn_app/repositories/via_cep_repository.dart';

class TestHttpPage extends StatefulWidget {
  const TestHttpPage({Key? key}) : super(key: key);

  @override
  State<TestHttpPage> createState() => _TestHttpPageState();
}

class _TestHttpPageState extends State<TestHttpPage> {
  TextEditingController zipCodeController = TextEditingController();
  ViaCepModel viaCepModel = ViaCepModel();
  bool isLoading = false;
  void searchZipCode() async {
    setState(() {
      isLoading = true;
    });
    if (int.tryParse(zipCodeController.text) == null &&
        zipCodeController.text.length != 8) {
      debugPrint("Invalid Zip Code");
      setState(() {
        isLoading = false;
      });
      return;
    }
    viaCepModel = await ViaCepRepository().fetchZipCode(zipCodeController.text);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  controller: zipCodeController,
                  decoration: const InputDecoration(
                    labelText: "Zip Code",
                    hintStyle: TextStyle(color: Colors.black),
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: "Type your Zip Code",
                  ))),
          TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.all(12.0),
                  textStyle: const TextStyle(fontSize: 18)),
              onPressed: searchZipCode,
              child: const Text("Buscar CEP",
                  style: TextStyle(color: Colors.white))),
          const SizedBox(
            height: 24,
          ),
          const Text(
            "Result",
            style: TextStyle(fontSize: 24),
          ),
          Visibility(
              visible: viaCepModel.cep?.isNotEmpty ?? false,
              child: Column(
                children: [
                  Text("Zip Code: ${viaCepModel.cep}"),
                  Text("City: ${viaCepModel.localidade}"),
                  Text("State: ${viaCepModel.uf}"),
                ],
              )),
          Visibility(
            visible: isLoading,
            child: const CircularProgressIndicator(
              color: Colors.black,
            ),
          )
        ],
      ),
    ));
  }
}