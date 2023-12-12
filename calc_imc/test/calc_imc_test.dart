import 'package:calc_imc/classes/Person.dart';
import 'package:test/test.dart';

void main() {
  test("testing IMC calculator", () {
    expect(Person.calcImc(1.70, 60), equals(20.76));
  });
}
