class Person {
  final String _name;
  final double _height;
  final double _weight;

  Person(this._name, this._height, this._weight);

  static double calcImc(double weight, double height) {
    var imc = weight / (height * height);
    return double.parse(imc.toStringAsFixed(2));
  }

  String resultsImc(double imc) {
    switch (imc) {
      case < 16:
        return "Underweight (Severe thinness)";
      case >= 16 && < 17:
        return "Underweight (Moderate thinness)";
      case >= 17 && < 18.5:
        return "Underweight (Mild thinness)";
      case >= 18.5 && < 25:
        return "Normal range";
      case >= 25 && < 30:
        return "Overweight (Pre-obese)";
      case >= 30 && < 35:
        return "Obese (Class I)";
      case >= 35 && < 40:
        return "Obese (Class II)";
      case >= 40:
        return "Obese (Class III) - (Severe obesity)";
      default:
        return "Invalid IMC";
    }
  }

  String imcResultText() {
    double imc = calcImc(_weight, _height);
    return "$imc IMC - ${resultsImc(imc)}";
  }

  @override
  String toString() {
    return "Patient $_name has a ${imcResultText()}";
  }
}
