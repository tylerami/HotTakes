import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:hottakes1/fire_icon_icons.dart' as FireIcon;
import 'package:hottakes1/services/gamemanager.dart';
import 'package:hottakes1/services/teams.dart';
import 'services/database.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'models/gamebutton.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool _team1status = false;
  bool _team2status = false;
  bool _team3status = false;
  bool _team4status = false;

  bool hasPicked() {
    if (this._team1status == false &&
        this._team2status == false &&
        this._team3status == false &&
        this._team4status == false)
      return false;
    else
      return true;
  }

  void select(index) {
    setState(() {
      switch (index) {
        case 1:
          this._team1status = true;
          this._team2status = false;
          this._team3status = false;
          this._team4status = false;
          break;
        case 2:
          this._team1status = false;
          this._team2status = true;
          this._team3status = false;
          this._team4status = false;
          break;
        case 3:
          this._team1status = false;
          this._team2status = false;
          this._team3status = true;
          this._team4status = false;
          break;
        case 4:
          this._team1status = false;
          this._team2status = false;
          this._team3status = false;
          this._team4status = true;
          break;
      }
    });
  }

  Future<GamePair> gp = DatabaseService().getGames(1, 2);
  @override
  void initState() {
    super.initState();
    gp = DatabaseService().getGames(1, 2);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    DatabaseService().updateUserGames(user.uid);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, AsyncSnapshot<UserData> snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return FutureBuilder<GamePair>(
                future: gp,
                builder: (context, snap) {
                  if (snap.hasData) {
                    GamePair gamePair = snap.data;
                    Game game1 = gamePair.game1;
                    Game game2 = gamePair.game2;
                    return Center(
                        child: Column(children: [
                      SizedBox(height: 20),
                      Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: 90,
                          //decoration: BoxDecoration(color: Color(0xff272727)
                          /*gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0xffFF7F31),
                      Color(0xffD45100)
                    ])), //Color(0xffDCDCDC)*/
                          //),
                          child: Column(
                            children: [
                              SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(CupertinoIcons.person,
                                      color: /*Color(0xff272727)*/ Colors.white
                                          .withOpacity(1),
                                      size: 40),
                                  SizedBox(width: 10),
                                  Text(userData.username,
                                      style: GoogleFonts.oswald(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 34,
                                          color: Colors.white.withOpacity(
                                              1))), //Color(0xff272727))),
                                  SizedBox(width: 8)
                                ],
                              ),
                              SizedBox(height: 1),
                              Container(
                                width: 350,
                                height: 1,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.2)),
                              ),
                              SizedBox(height: 5),
                              Text(
                                  "CURRENT STREAK: " +
                                      userData.streak.toString(),
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white))
                            ],
                          )),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 250, 10),
                        child: Text('GAME 1',
                            style: GoogleFonts.roboto(
                                color: Color(0xff777777),
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                      ),
                      InkWell(
                          onTap: () {
                            select(1);
                          },
                          child: GameButton(
                              top: true,
                              city: Teams().cityFromInitials(game1.team1),
                              team: Teams().teamFromInitials(game1.team1),
                              subtitle: game1.subtitle1,
                              logo: 'assets/denver.png',
                              odds: game1.odds1,
                              selected: this._team1status ? true : false)),
                      Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.3))),
                      InkWell(
                          onTap: () {
                            select(2);
                          },
                          child: GameButton(
                              top: false,
                              city: Teams().cityFromInitials(game1.team2),
                              team: Teams().teamFromInitials(game1.team2),
                              subtitle: game1.subtitle2,
                              logo: 'assets/jets.png',
                              odds: game1.odds2,
                              selected: this._team2status ? true : false)),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 250, 10),
                        child: Text('GAME 2',
                            style: GoogleFonts.roboto(
                                color: Color(0xff777777),
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                      ),
                      InkWell(
                          onTap: () {
                            select(3);
                          },
                          child: GameButton(
                              top: true,
                              city: Teams().cityFromInitials(game2.team1),
                              team: Teams().teamFromInitials(game2.team1),
                              subtitle: game2.subtitle1,
                              logo: 'assets/la.png',
                              odds: game2.odds1,
                              selected: this._team3status ? true : false)),
                      Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.3))),
                      InkWell(
                          onTap: () {
                            select(4);
                          },
                          child: GameButton(
                              top: false,
                              city: Teams().cityFromInitials(game2.team2),
                              team: Teams().teamFromInitials(game2.team2),
                              subtitle: game2.subtitle2,
                              logo: 'assets/jets.png',
                              odds: game2.subtitle2,
                              selected: this._team4status ? true : false)),
                      SizedBox(height: hasPicked() ? 22 : 32),
                      Container(
                        width: 280,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Color(0xffFF6400), Colors.red[600]])),
                        child: CupertinoButton(
                            padding: EdgeInsets.all(12),
                            //color: Color(0xffFF6400),
                            borderRadius: BorderRadius.circular(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('SUBMIT TAKE',
                                    style: GoogleFonts.oswald(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff272727))),
                                SizedBox(width: 10),
                                Icon(FireIcon.FireIcon.fire,
                                    size: 30, color: Color(0xff272727))
                              ],
                            ),
                            onPressed: hasPicked()
                                ? () {
                                    setState(() {
                                      this._team1status = false;
                                      this._team2status = false;
                                      this._team3status = false;
                                      this._team4status = false;
                                    });
                                  }
                                : null),
                      )
                    ]));
                  } else
                    return Container();
                });
          } else
            return Container();
        });
  }
}
