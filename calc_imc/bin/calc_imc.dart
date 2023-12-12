import 'package:calc_imc/classes/Person.dart';
import 'package:calc_imc/utils/read_entry.dart';

void main(List<String> arguments) {
  String name = ReadEntry.textEntryWithDescritpion("Enter your name: ");
  double height = ReadEntry.numberEntryWithDescritpion("Enter your height: ");
  double weight = ReadEntry.numberEntryWithDescritpion("Enter your weight: ");

  var person = Person(name, height, weight);
  print(person);
}
