import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home_vieww.dart';

class MainManuView extends StatefulWidget {
  const MainManuView({super.key});

  @override
  State<MainManuView> createState() => _MainManuViewState();
}

class _MainManuViewState extends State<MainManuView> {
  int tabIndex = 0;
  List<Widget> viewScreen = [];
  String? profPicture;
  String? token;
  final PageStorageBucket bucket = PageStorageBucket();

  Widget buildPageView() {
    return const TabBarView(
      children: [
        HomeView(),
        HomeView(),
        HomeView(),
        HomeView(),
        HomeView(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _defaultTabBar;
  }

  Widget get _defaultTabBar => DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        body: buildPageView(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
            elevation: 10,
            child: const Icon(Icons.camera_alt_sharp),
            onPressed: () {}),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 6,
          child: SizedBox(
            height: 80,
            child: TabBar(
                indicatorColor: Colors.transparent,
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.green,
                tabs: <Widget>[
                  Tab(
                    child: FaIcon(FontAwesomeIcons.film, size: 20),
                  ),
                  Tab(
                    child: FaIcon(FontAwesomeIcons.clapperboard, size: 20),
                  ),
                  Tab(
                    child: SizedBox(),
                  ),
                  Tab(
                    child: FaIcon(FontAwesomeIcons.networkWired, size: 20),
                  ),
                  Tab(
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage("https://picsum.photos/200/300"),
                    ),
                  ),
                ]),
          ),
        ),
      ));
}
