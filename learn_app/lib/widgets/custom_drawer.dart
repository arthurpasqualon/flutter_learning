import 'package:flutter/material.dart';
import 'package:learn_app/pages/auto_size_text.dart';
import 'package:learn_app/pages/imc_calc_page.dart';
import 'package:learn_app/pages/login_page.dart';
import 'package:learn_app/pages/profile.dart';
import 'package:learn_app/pages/counter_page_provider.dart';
import 'package:learn_app/pages/settings_page.dart';
import 'package:learn_app/pages/test_http_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16))),
                      builder: (BuildContext buildContext) {
                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: Wrap(
                            spacing: 8,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera_alt_outlined),
                                title: const Text("Camera"),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_outlined),
                                title: const Text("Gallery"),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(color: Colors.transparent),
                    accountName: const Text("Arthur",
                        style: TextStyle(color: Colors.black)),
                    accountEmail: const Text("arthur@email.com",
                        style: TextStyle(color: Colors.black)),
                    currentAccountPicture: CircleAvatar(
                      child: ClipOval(
                        child: Image.network(
                          "https://avatars.githubusercontent.com/u/20956158?v=4",
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Row(
                    children: [
                      Icon(Icons.home_outlined),
                      SizedBox(width: 8),
                      Text("Home"),
                    ],
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Profile();
                  }));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Row(
                    children: [
                      Icon(Icons.person_outline),
                      SizedBox(width: 8),
                      Text("Profile"),
                    ],
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SettingsPage();
                  }));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Row(
                    children: [
                      Icon(Icons.settings_outlined),
                      SizedBox(width: 8),
                      Text("Settings"),
                    ],
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ImcCalcPage();
                  }));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Row(
                    children: [
                      Icon(Icons.monitor_heart_outlined),
                      SizedBox(width: 8),
                      Text("Your Health"),
                    ],
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CounterPageProvider();
                  }));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Row(
                    children: [
                      Icon(Icons.text_decrease),
                      SizedBox(width: 8),
                      Text("Numbers Provider"),
                    ],
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const TestHttpPage();
                  }));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Row(
                    children: [
                      Icon(Icons.pin_drop),
                      SizedBox(width: 8),
                      Text("Get CEP"),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Logout"),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          content: const Text("Are you sure want to logout?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return const LoginPage();
                                    }),
                                  );
                                },
                                child: const Text("Logout")),
                          ],
                        );
                      });
                },
                child: const Text("Logout"),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text("Terms of Service"),
            ]),
          )),
    );
  }
}
