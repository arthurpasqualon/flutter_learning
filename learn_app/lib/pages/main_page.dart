import 'package:flutter/material.dart';
import 'package:learn_app/pages/post_page.dart';
import 'package:learn_app/pages/list_view_vertical.dart';
import 'package:learn_app/pages/task_page.dart';
import 'package:learn_app/pages/test_http_page.dart';
import 'package:learn_app/widgets/custom_drawer.dart';

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
      drawer: const CustomDrawer(),
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
              children: const [
                TestHttpPage(),
                PostPage(),
                ListViewVertical(),
                TaskPage()
              ],
            ),
          ),
          BottomNavigationBar(
              currentIndex: currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (value) => setState(() => {
                    currentIndex = value,
                    pageController.animateToPage(value,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn)
                  }),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.list), label: "Posts"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline), label: "Profile"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list_alt), label: "Settings"),
              ])
        ],
      ),
    );
  }
}
