import 'package:flutter/material.dart';
import 'package:learn_app/repositories/languages_repository.dart';
import 'package:learn_app/repositories/level_repository.dart';
import 'package:learn_app/services/app_storage_service.dart';
import 'package:learn_app/widgets/section_divider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AppStorageService storage = AppStorageService();

  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController birthDateController = TextEditingController(text: "");
  DateTime? birthDate;
  var levelRepository = LevelRepository();
  var powersRepository = PowersRepository();
  var powers = [];
  var levels = [];
  var selectedLevel = "";
  var selectedPowers = [""];
  var hoursPerWeek = 20.0;
  var yearsOfExperience = 0;
  bool loading = false;

  @override
  void initState() {
    levels = levelRepository.getLevels();
    powers = powersRepository.getPowers();
    super.initState();
    loadSettings();
  }

  void loadSettings() async {
    selectedLevel = await storage.selectedLevel;
    selectedPowers = await storage.selectedPowers;
    hoursPerWeek = await storage.hoursPerWeek;
    yearsOfExperience = await storage.yearsOfExperience;
    emailController.text = await storage.email;
    birthDateController.text = await storage.birthDateText;
    birthDate = await storage.birthDate;
    setState(() {});
  }

  List<DropdownMenuItem<int>> renderExperienceYearsList(int max) {
    List<DropdownMenuItem<int>> list = [];
    for (var i = 0; i <= max; i++) {
      list.add(DropdownMenuItem(
        value: i,
        child: Text(i.toString()),
      ));
    }
    return list;
  }

  void onSaveSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profile updated"),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  void onFinishEditing() async {
    String email = emailController.text;
    String date = birthDateController.text;

    if (email.trim().length <= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email must be longer than 3 characters"),
          backgroundColor: Colors.red,
        ),
      );
    } else if (date.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Birth date cannot be empty"),
          backgroundColor: Colors.red,
        ),
      );
    } else if (selectedLevel.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select your experience level"),
          backgroundColor: Colors.red,
        ),
      );
    } else if (selectedPowers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select your powers"),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      setState(() {
        loading = true;
      });
      await storage.setEmail(email);
      await storage.setBirthDate(date);
      await storage.setSelectedLevel(selectedLevel);
      await storage.setSelectedPowers(selectedPowers);
      await storage.setHoursPerWeek(hoursPerWeek);
      await storage.setYearsOfExperience(yearsOfExperience);

      setState(() {
        loading = false;
      });
      onSaveSuccess();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : ListView(
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                      ),
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Birth Date",
                      ),
                      readOnly: true,
                      onTap: () async {
                        var data = await showDatePicker(
                          context: context,
                          initialDate: birthDate ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (data != null) {
                          birthDateController.text = data.toString();
                          setState(() {
                            birthDate = data;
                          });
                        }
                      },
                      controller: birthDateController,
                    ),
                    const Section(text: "Experience level"),
                    Column(
                      children: levels.map((level) {
                        return RadioListTile(
                          value: level,
                          title: Text(level),
                          groupValue: selectedLevel,
                          activeColor: Colors.black,
                          onChanged: (value) {
                            setState(() {
                              selectedLevel = value.toString();
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const Section(text: "Your powers"),
                    Column(
                      children: powers.map((power) {
                        return CheckboxListTile(
                          value: selectedPowers.contains(power),
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                selectedPowers.add(power);
                              } else {
                                selectedPowers.remove(power);
                              }
                            });
                          },
                          title: Text(power),
                        );
                      }).toList(),
                    ),
                    const Section(
                        text:
                            "How many hours/week do you dedicate to improve your powers?"),
                    Slider(
                        min: 0.0,
                        max: 168.0,
                        value: hoursPerWeek,
                        onChanged: (value) {
                          setState(() {
                            hoursPerWeek = value;
                          });
                        }),
                    Center(child: Text("${hoursPerWeek.toInt()} hours/week")),
                    const Section(
                        text: "How many years of experience do you have?"),
                    DropdownButton(
                        value: yearsOfExperience.toInt(),
                        isExpanded: true,
                        items: renderExperienceYearsList(20),
                        onChanged: (value) {
                          setState(() {
                            yearsOfExperience = int.parse(value.toString());
                          });
                        }),
                    TextButton(
                      onPressed: onFinishEditing,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: const Text("Save"),
                    ),
                  ],
                ),
        ));
  }
}
