import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hottakes1/fire_icon_icons.dart' as FireIcon;
import 'package:hottakes1/services/auth.dart';
import 'package:hottakes1/services/database.dart';
import 'package:hottakes1/settings.dart';
import 'streaks.dart';
import 'prizes.dart';
import 'homescreen.dart';
import 'main.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _DashboardState createState() => new _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Widget> tabs = [Streaks(), Homescreen(), Prizes(), Settings()];

  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return Scaffold(
        body: user.uid != null
            ? CupertinoTabScaffold(
                backgroundColor: Color(0xff1A1A1A),
                tabBar: CupertinoTabBar(
                    backgroundColor: Color(0xff111111),
                    currentIndex: _currentIndex,
                    activeColor: Color(0xffFF6400),
                    inactiveColor: Colors.white,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.clock),
                        label: 'Streaks',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(FireIcon.FireIcon.fire),
                        label: 'Takes',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.gift),
                        label: 'Prizes',
                      )
                    ],
                    onTap: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    }),
                tabBuilder: (BuildContext context, _currentIndex) {
                  switch (_currentIndex) {
                    case 0:
                      return CupertinoTabView(
                        builder: (BuildContext context) =>
                            CupertinoPageScaffold(
                          backgroundColor: Color(0xff1A1A1A),
                          child: Streaks(),
                          navigationBar: CupertinoNavigationBar(
                              backgroundColor: Color(0xff111111),
                              middle: Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 40),
                                      Image.asset('assets/logohor.png',
                                          height: 60),
                                    ],
                                  )),
                              trailing: Padding(
                                padding: EdgeInsets.all(5),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(CupertinoPageRoute<bool>(
                                            builder: (BuildContext context) =>
                                                Settings()));
                                  },
                                  child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color(0xff2F2F2F)),
                                      child: Icon(Icons.settings_sharp,
                                          color: Colors.white.withOpacity(.6),
                                          size: 25)),
                                ),
                              )),
                        ),
                      );
                      break;
                    case 1:
                      return CupertinoTabView(
                        builder: (BuildContext context) =>
                            CupertinoPageScaffold(
                          backgroundColor: Color(0xff1A1A1A),
                          child: Homescreen(),
                          navigationBar: CupertinoNavigationBar(
                              backgroundColor: Color(0xff111111),
                              middle: Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 40),
                                      Image.asset('assets/logohor.png',
                                          height: 60),
                                    ],
                                  )),
                              trailing: Padding(
                                padding: EdgeInsets.all(5),
                                child: GestureDetector(
                                  onTap: user.uid != null
                                      ? () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .push(CupertinoPageRoute<bool>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          Settings()));
                                        }
                                      : () {},
                                  child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color(0xff2F2F2F)),
                                      child: Icon(Icons.settings_sharp,
                                          color: Colors.white.withOpacity(.6),
                                          size: 25)),
                                ),
                              )),
                        ),
                      );
                      break;
                    case 2:
                      return CupertinoTabView(
                        builder: (BuildContext context) =>
                            CupertinoPageScaffold(
                          backgroundColor: Color(0xff1A1A1A),
                          child: Prizes(),
                          navigationBar: CupertinoNavigationBar(
                              backgroundColor: Color(0xff111111),
                              middle: Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 40),
                                      Image.asset('assets/logohor.png',
                                          height: 60),
                                    ],
                                  )),
                              trailing: Padding(
                                padding: EdgeInsets.all(5),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(CupertinoPageRoute<bool>(
                                            builder: (BuildContext context) =>
                                                Settings()));
                                  },
                                  child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color(0xff2F2F2F)),
                                      child: Icon(Icons.settings_sharp,
                                          color: Colors.white.withOpacity(.6),
                                          size: 25)),
                                ),
                              )),
                        ),
                      );
                      break;
                    default:
                      return null;
                  }
                },
              )
            : Container());
  }
}
