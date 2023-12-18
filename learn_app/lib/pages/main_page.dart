import 'package:flutter/material.dart';
import 'package:learn_app/pages/main_page_1.dart';
import 'package:learn_app/pages/main_page_2.dart';
import 'package:learn_app/pages/main_page_3.dart';
import 'package:learn_app/pages/profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Page"),
      ),
      drawer: Drawer(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text("Home"),
                      ),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Profile(
                              email: "email@email.com",
                              birthDate: "01-01-2001");
                        }));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text("Profile"),
                      ),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text("Settings"),
                      ),
                    ),
                    const Divider(),
                    Expanded(child: Container()),
                    const Text("Logout"),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text("Terms of Service"),
                  ]),
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: const [MainPage1(), MainPage2(), MainPage3()],
            ),
          ),
          BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (value) => setState(() => {
                    currentIndex = value,
                    pageController.animateToPage(value,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn)
                  }),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border_outlined),
                    label: "Favorite"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline), label: "Profile"),
              ])
        ],
      ),
    );
  }
}
