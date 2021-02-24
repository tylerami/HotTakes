import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hottakes1/services/database.dart';
import 'package:hottakes1/services/gamemanager.dart';
import 'package:hottakes1/services/gameviewer.dart';
import 'package:hottakes1/services/unfinishedgames.dart';
import 'package:hottakes1/services/setgame.dart';
import 'package:hottakes1/services/updateodds.dart';
import 'package:hottakes1/services/setwinner.dart';

class ControlPanel extends StatefulWidget {
  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Localizations(
            locale: const Locale('en', 'US'),
            delegates: <LocalizationsDelegate<dynamic>>[
              DefaultWidgetsLocalizations.delegate,
              DefaultMaterialLocalizations.delegate,
            ],
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 8),
                    GestureDetector(
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
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => SetGame()));
                      },
                      child: Container(
                          width: 130,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff2F2F2F)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Set new game',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 12)),
                              Icon(Icons.arrow_forward_ios_rounded,
                                  color: Colors.white.withOpacity(.6),
                                  size: 12),
                            ],
                          )),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => UpdateOdds()));
                      },
                      child: Container(
                          width: 130,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff2F2F2F)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Update odds',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 12)),
                              Icon(Icons.arrow_forward_ios_rounded,
                                  color: Colors.white.withOpacity(.6),
                                  size: 12),
                            ],
                          )),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => SetWinner()));
                      },
                      child: Container(
                          width: 130,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff2F2F2F)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Set Winner',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 12)),
                              Icon(Icons.arrow_forward_ios_rounded,
                                  color: Colors.white.withOpacity(.6),
                                  size: 12),
                            ],
                          )),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => GameViewer()));
                      },
                      child: Container(
                          width: 130,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff2F2F2F)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Uploaded Games',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 12)),
                              Icon(Icons.arrow_forward_ios_rounded,
                                  color: Colors.white.withOpacity(.6),
                                  size: 12),
                            ],
                          )),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => UnfinishedGames()));
                      },
                      child: Container(
                          width: 130,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff2F2F2F)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Unfinished Games',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 12)),
                              Icon(Icons.arrow_forward_ios_rounded,
                                  color: Colors.white.withOpacity(.6),
                                  size: 12),
                            ],
                          )),
                    )
                  ],
                )),
              ),
            )));
  }
}
