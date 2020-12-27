import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hottakes1/models/user.dart';
import 'package:hottakes1/services/auth.dart';
import 'package:hottakes1/services/controlpanel.dart';
import 'package:hottakes1/services/database.dart';
import 'package:hottakes1/settings/deliveryform.dart';
import 'package:hottakes1/settings/flutter_cupertino_settings.dart';
import 'package:hottakes1/settings/passwordform.dart';
import 'package:hottakes1/settings/usernameform.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();
  String uid = '';
  bool _switch = true;
  CSWidgetStyle brightnessStyle = const CSWidgetStyle(
      icon: const Icon(Icons.brightness_medium, color: Colors.black54));

  @override
  void didChangeDependencies() {
    final user = Provider.of<MyUser>(context);
    uid = user != null ? user.uid : '';
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: true,
        navigationBar: CupertinoNavigationBar(
            backgroundColor: Color(0xff111111),
            middle: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Settings',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.normal,
                            color: Colors.white)),
                    SizedBox(width: 50),
                  ],
                )),
            leading: Padding(
              padding: EdgeInsets.all(5),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff2F2F2F)),
                    child: Icon(Icons.arrow_back_ios_rounded,
                        color: Colors.white.withOpacity(.6), size: 25)),
              ),
            )),
        child: uid != ''
            ? StreamProvider<UserData>.value(
                value: DatabaseService(uid: uid).userData,
                builder: (context, child) {
                  final userData = Provider.of<UserData>(context);
                  if (userData != null) {
                    _switch = userData.notifications;
                    return CupertinoSettings(
                      items: <Widget>[
                        CSHeader('PREMIUM'),
                        CSLink(
                          title: 'Upgrade your experience',
                          trailing: Icon(CupertinoIcons.chevron_right),
                        ),
                        CSHeader('SECURITY'),
                        CSLink(
                          title: 'Update password',
                          trailing: Icon(CupertinoIcons.chevron_right),
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        PasswordForm(isEmailLink: false)));
                          },
                        ),
                        CSLink(
                          title: 'Change username',
                          trailing: Icon(CupertinoIcons.chevron_right),
                          onPressed: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => UsernameForm()));
                          },
                        ),
                        CSHeader('APP SETTINGS'),
                        CSControl(
                          contentWidget: CupertinoSwitch(
                              value: _switch,
                              activeColor: CupertinoColors.activeBlue,
                              onChanged: (bool value) {
                                setState(() => _switch = value);
                                DatabaseService().setNotifications(uid, value);
                              }),
                          nameWidget: Text('Notifications'),
                        ),
                        CSLink(
                            title: 'League preferences',
                            trailing: Icon(CupertinoIcons.chevron_right),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Leagues()));
                            }),
                        CSLink(
                            title: 'Prize Delivery',
                            trailing: Icon(CupertinoIcons.chevron_right),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          DeliveryForm(prizeIndex: 0)));
                            }),
                        CSLink(
                            title: 'Logout',
                            trailing: Icon(CupertinoIcons.chevron_right),
                            onPressed: () async {
                              await _auth.signOut();
                              Navigator.of(context).pop();
                            }),
                        Container(
                            child: uid != ''
                                ? uid == 'ZFczk4pT3GMU6l8QzswZEC5DHTj2'
                                    ? CSLink(
                                        title: 'Admin Control',
                                        trailing:
                                            Icon(CupertinoIcons.chevron_right),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      ControlPanel()));
                                        },
                                      )
                                    : SizedBox()
                                : SizedBox())
                      ],
                    );
                  } else
                    return Container();
                })
            : Container());
  }
}

class Leagues extends StatefulWidget {
  @override
  _LeaguesState createState() => _LeaguesState();
}

class _LeaguesState extends State<Leagues> {
  int firstIndex;
  int secondIndex;

  int indexFromLeague(String league) {
    int i = 0;
    switch (league) {
      case 'NFL':
        i = 0;
        break;
      case 'NBA':
        i = 1;
        break;
      case 'NHL':
        i = 2;
        break;
      case 'MLB':
        i = 3;
        break;
      default:
        i = 1;
    }
    return i;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return StreamProvider<UserData>.value(
        value: DatabaseService(uid: user.uid).userData,
        builder: (context, child) {
          final userData = Provider.of<UserData>(context) ?? null;
          if (userData != null) {
            firstIndex = indexFromLeague(userData.league1);
            secondIndex = indexFromLeague(userData.league2);
            return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                    backgroundColor: Color(0xff111111),
                    middle: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('League Preferences',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'SFProDisplay',
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white)),
                            SizedBox(width: 50),
                          ],
                        )),
                    leading: Padding(
                      padding: EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xff2F2F2F)),
                            child: Icon(Icons.arrow_back_ios_rounded,
                                color: Colors.white.withOpacity(.6), size: 25)),
                      ),
                    )),
                child: CupertinoSettings(items: <Widget>[
                  CSHeader('FIRST PREFERENCE'),
                  CSSelection<int>(
                    items: <CSSelectionItem<int>>[
                      CSSelectionItem<int>(text: 'NFL', value: 0),
                      CSSelectionItem<int>(text: 'NBA', value: 1),
                      CSSelectionItem<int>(text: 'NHL', value: 2),
                      CSSelectionItem<int>(text: 'MLB', value: 3)
                    ],
                    currentSelection: firstIndex,
                    onSelected: (index) {
                      firstIndex = index;
                      DatabaseService().setLeague1(userData.uid, index);
                    },
                  ),
                  CSHeader('SECOND PREFERENCE'),
                  CSSelection<int>(
                    items: <CSSelectionItem<int>>[
                      CSSelectionItem<int>(text: 'NFL', value: 0),
                      CSSelectionItem<int>(text: 'NBA', value: 1),
                      CSSelectionItem<int>(text: 'NHL', value: 2),
                      CSSelectionItem<int>(text: 'MLB', value: 3)
                    ],
                    currentSelection: secondIndex,
                    onSelected: (index) {
                      secondIndex = index;
                      DatabaseService().setLeague2(userData.uid, index);
                    },
                  )
                ]));
          } else
            return Container();
        });
  }
}
