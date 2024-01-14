import 'package:hive/hive.dart';
part 'profile_model.g.dart';

@HiveType(typeId: 0)
class ProfileModel extends HiveObject {
  @HiveField(0)
  String? email;

  @HiveField(1)
  DateTime? birthDate;

  @HiveField(2)
  int? yearsOfExperience;

  @HiveField(3)
  List<String> selectedPowers = [];

  @HiveField(4)
  String? selectedLevel;

  @HiveField(5)
  double? hoursPerWeek;

  ProfileModel();
  ProfileModel.empty() {
    email = '';
    birthDate = DateTime.now();
    yearsOfExperience = 0;
    hoursPerWeek = 0.0;
    selectedPowers = [];
    selectedLevel = '';
  }
}
