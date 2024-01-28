import 'dart:convert';

import 'package:learn_app/model/via_cep_model.dart';
import 'package:http/http.dart' as http;

class ViaCepRepository {
  Future<ViaCepModel> fetchZipCode(String zipCode) async {
    try {
      final response =
          await http.get(Uri.parse('https://viacep.com.br/ws/$zipCode/json/'));
      return ViaCepModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Erro ao buscar CEP');
    }
  }
}
