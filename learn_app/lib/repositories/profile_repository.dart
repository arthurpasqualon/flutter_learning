import 'package:hive/hive.dart';
import 'package:learn_app/model/profile_model.dart';

class ProfileRepository {
  static late Box _box;

  // ignore: constant_identifier_names
  static const PROFILE_KEY = 'profile';

  ProfileRepository._create();

  static Future<ProfileRepository> load() async {
    if (Hive.isBoxOpen(PROFILE_KEY)) {
      _box = Hive.box(PROFILE_KEY);
    } else {
      _box = await Hive.openBox(PROFILE_KEY);
    }
    return ProfileRepository._create();
  }

  void save(ProfileModel profile) {
    _box.put(PROFILE_KEY, profile);
  }

  ProfileModel getData() {
    var profile = _box.get(PROFILE_KEY);
    if (profile == null) {
      return ProfileModel.empty();
    }
    return profile;
  }
}
