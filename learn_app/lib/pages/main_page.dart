import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learn_app/pages/characters_page.dart';
import 'package:learn_app/pages/post_page.dart';
import 'package:learn_app/pages/list_view_vertical.dart';
import 'package:learn_app/pages/task_page.dart';
import 'package:learn_app/widgets/custom_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 4, vsync: this);
  }

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
            child: TabBarView(
              controller: tabController,
              // onPageChanged: (index) {
              //   setState(() {
              //     currentIndex = index;
              //   });
              // },
              children: const [
                CharactersPage(),
                PostPage(),
                ListViewVertical(),
                TaskPage()
              ],
            ),
          ),
          ConvexAppBar(
            controller: tabController,
            backgroundColor: Colors.black,
            items: const [
              TabItem(icon: Icons.shield, title: 'Heroes'),
              TabItem(icon: Icons.newspaper, title: 'Posts'),
              TabItem(icon: Icons.person, title: 'Profile'),
              TabItem(icon: Icons.list_alt, title: 'Tasks'),
            ],
            onTap: (value) => tabController.index = value,
          )
        ],
      ),
    );
  }
}
