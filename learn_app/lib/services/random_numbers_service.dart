import 'dart:math';

class RandomNumbersService {
  static int generateRandomNumber(int max) {
    var generatedNumber = Random().nextInt(max);
    return generatedNumber;
  }
}
