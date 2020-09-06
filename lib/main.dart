
import 'package:diabeteshelper/pages/home.dart';
import 'package:diabeteshelper/pages/respage.dart';
import 'package:diabeteshelper/pages/logbook.dart';
import 'package:diabeteshelper/pages/splashscreen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(Myapp());
}
class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: SplashScreen(),

    );
  }
}
class start extends StatefulWidget {
  @override
  _startState createState() => _startState();
}

class _startState extends State<start> {
  PageController pageController;
  int _page = 0;



  @override
  void initState() {
    super.initState();
    pageController = PageController();

  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Container(
            child: home(),
          ),
          Container(
            child: insulincal(),
          ),
          Container(
            child: logbook(),
          ),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
        bottomNavigationBar: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: CupertinoTabBar(
              backgroundColor: Colors.transparent,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.search,
                      color: (_page == 0)
                          ? Colors.green
                          : Colors.grey),
                  title: Text(
                    "Search",
                    style: TextStyle(
                        fontSize: 10,
                        color: (_page == 0)
                            ? Colors.green
                            : Colors.grey),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.trip_origin,
                      color: (_page == 1)
                          ? Colors.green
                          : Colors.grey),
                  title: Text(
                    "Resources",
                    style: TextStyle(
                        fontSize:10,
                        color: (_page == 1)
                            ? Colors.green
                            : Colors.grey),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.data_usage,
                      color: (_page == 2)
                          ? Colors.green
                          : Colors.grey),
                  title: Text(
                    "Log book",
                    style: TextStyle(
                        fontSize:10,
                        color: (_page == 2)
                            ? Colors.green
                            : Colors.grey),
                  ),
                ),
              ],
              onTap: navigationTapped,
              currentIndex: _page,
            ),
          ),
        )
    );
  }
}




