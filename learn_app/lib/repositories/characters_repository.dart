import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:learn_app/model/characters_model.dart';

class CharactersRepository {
  Future<CharactersModel> fetchCharacters() async {
    var dio = Dio();
    var ts = DateTime.now().millisecondsSinceEpoch.toString();
    var publicKey = dotenv.get("MARVELAPIKEY");
    var privateKey = dotenv.get("MARVELPRIVATEKEY");
    var hash = _generateMd5(ts + privateKey + publicKey);
    var query = "?ts=$ts&apikey=$publicKey&hash=$hash";
    var result =
        await dio.get("https://gateway.marvel.com/v1/public/characters$query");

    if (result.statusCode != 200) {
      throw Exception();
    }
    var charactersModel = CharactersModel.fromJson(result.data);

    return charactersModel;
  }

  _generateMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}
