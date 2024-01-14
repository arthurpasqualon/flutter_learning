class ImcCalculatorService {
  static double calculateImc(double weight, double height) {
    var imc = weight / (height * height);
    return double.parse(imc.toStringAsFixed(2));
  }

  static String resultImcText(double imc) {
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
}
