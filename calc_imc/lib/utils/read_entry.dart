import 'dart:convert';
import 'dart:io';

class ReadEntry {
  static String textEntryWithDescritpion(String description) {
    print(description);
    var entry = stdin.readLineSync(encoding: utf8) ?? "";
    if (double.tryParse(entry) != null) {
      entry = "";
    }

    if (entry.isEmpty) {
      print("Invalid entry, please enter a valid name");
      entry = textEntryWithDescritpion(description);
    }
    return entry;
  }

  static double numberEntryWithDescritpion(String description) {
    print(description);
    double number = 0.0;

    try {
      number = double.parse(stdin.readLineSync(encoding: utf8) ?? "");
    } catch (e) {
      print("Invalid entry, please enter a valid number");
      number = numberEntryWithDescritpion(description);
    }

    if (number <= 0) {
      print("Invalid entry, please enter a valid number");
      number = numberEntryWithDescritpion(description);
    }

    return number;
  }
}
