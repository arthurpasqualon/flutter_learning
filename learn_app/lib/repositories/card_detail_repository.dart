import 'package:learn_app/model/card_detail_model.dart';

class CardDetailRepository {
  Future<CardDetailModel> getCardDetail(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    return CardDetailModel(
        1,
        "Arthur Neves Pasqualon",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget aliquam ultricies, nunc nisl ultricies nunc, quis aliquet nisl nunc eu nisl. Donec euismod, nisl eget aliquam ultricies, nunc nisl ultricies nunc, quis aliquet nisl nunc eu nisl.",
        "https://avatars.githubusercontent.com/u/20956158?v=4");
  }
}
