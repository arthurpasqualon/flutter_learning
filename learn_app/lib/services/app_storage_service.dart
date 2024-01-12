import 'package:shared_preferences/shared_preferences.dart';

enum Keys {
  isDarkMode,
  receiveNotification,
  selectedLevel,
  selectedPowers,
  hoursPerWeek,
  yearsOfExperience,
  email,
  birthDate,
  randomNumber,
  clickCount
}

class AppStorageService {
  Future<bool> get isDarkMode async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Keys.isDarkMode.toString()) ?? false;
  }

  Future<void> setDarkMode(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Keys.isDarkMode.toString(), value);
  }

  Future<bool> get receiveNotification async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Keys.receiveNotification.toString()) ?? false;
  }

  Future<void> setReceiveNotification(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Keys.receiveNotification.toString(), value);
  }

  Future<String> get selectedLevel async {
    return _getString(Keys.selectedLevel.toString());
  }

  Future<void> setSelectedLevel(String value) async {
    await _setString(Keys.selectedLevel.toString(), value);
  }

  Future<List<String>> get selectedPowers async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(Keys.selectedPowers.toString()) ?? [];
  }

  Future<void> setSelectedPowers(List<String> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(Keys.selectedPowers.toString(), value);
  }

  Future<double> get hoursPerWeek async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(Keys.hoursPerWeek.toString()) ?? 0.0;
  }

  Future<void> setHoursPerWeek(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(Keys.hoursPerWeek.toString(), value);
  }

  Future<int> get yearsOfExperience async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(Keys.yearsOfExperience.toString()) ?? 0;
  }

  Future<void> setYearsOfExperience(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(Keys.yearsOfExperience.toString(), value);
  }

  Future<String> get email async {
    return _getString(Keys.email.toString());
  }

  Future<void> setEmail(String value) async {
    await _setString(Keys.email.toString(), value);
  }

  Future<String> get birthDateText async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Keys.birthDate.toString()) ?? "";
  }

  Future<DateTime> get birthDate async {
    String dateString = await _getString(Keys.birthDate.toString());
    return DateTime.parse(
        dateString == "" ? DateTime.now().toString() : dateString);
  }

  Future<void> setBirthDate(String value) async {
    await _setString(Keys.birthDate.toString(), value);
  }

  Future<int> get randomNumber async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(Keys.randomNumber.toString()) ?? 0;
  }

  Future<void> setRandomNumber(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(Keys.randomNumber.toString(), value);
  }

  Future<int> get clickCount async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(Keys.clickCount.toString()) ?? 0;
  }

  Future<void> setClickCount(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(Keys.clickCount.toString(), value);
  }

  _setString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String> _getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }
}
