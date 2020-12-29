import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:hottakes1/models/fire_icon_icons.dart';
import 'package:hottakes1/models/gamebutton.dart';
import 'package:hottakes1/models/user.dart';
import 'package:hottakes1/services/database.dart';
import 'package:hottakes1/services/gamemanager.dart';
import 'package:hottakes1/services/teams.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool _team1status = false;
  bool _team2status = false;
  bool _team3status = false;
  bool _team4status = false;
  bool buttonEnabled = false;

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

  bool _team1submission = false;
  bool _team2submission = false;
  bool _team3submission = false;
  bool _team4submission = false;

  bool hasSubmit() {
    if (this._team1submission == false &&
        this._team2submission == false &&
        this._team3submission == false &&
        this._team4submission == false)
      return false;
    else
      return true;
  }

  void submit(index) {
    setState(() {
      switch (index) {
        case 1:
          this._team1submission = true;
          this._team2submission = false;
          this._team3submission = false;
          this._team4submission = false;
          break;
        case 2:
          this._team1submission = false;
          this._team2submission = true;
          this._team3submission = false;
          this._team4submission = false;
          break;
        case 3:
          this._team1submission = false;
          this._team2submission = false;
          this._team3submission = true;
          this._team4submission = false;
          break;
        case 4:
          this._team1submission = false;
          this._team2submission = false;
          this._team3submission = false;
          this._team4submission = true;
          break;
        default:
          break;
      }
    });
  }

  void submitDuringBuild(index) {
    switch (index) {
      case 1:
        this._team1submission = true;
        this._team2submission = false;
        this._team3submission = false;
        this._team4submission = false;
        break;
      case 2:
        this._team1submission = false;
        this._team2submission = true;
        this._team3submission = false;
        this._team4submission = false;
        break;
      case 3:
        this._team1submission = false;
        this._team2submission = false;
        this._team3submission = true;
        this._team4submission = false;
        break;
      case 4:
        this._team1submission = false;
        this._team2submission = false;
        this._team3submission = false;
        this._team4submission = true;
        break;
      default:
        break;
    }
  }

  int getSubmissionIndex() {
    if (this._team1status)
      return 1;
    else if (this._team2status)
      return 2;
    else if (this._team3status)
      return 3;
    else if (this._team4status)
      return 4;
    else
      return null;
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
    return SingleChildScrollView(
      child: StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, AsyncSnapshot<UserData> snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;
              submitDuringBuild(userData.currentPick);
              return FutureBuilder<GamePair>(
                  future: gp,
                  builder: (context, snap) {
                    if (snap.hasData) {
                      GamePair gamePair = snap.data;
                      Game game1 = gamePair.game1;
                      Game game2 = gamePair.game2;
                      if (userData.picksRemaining >= 1) {}
                      return Center(
                          child: Column(children: [
                        SizedBox(height: 20),
                        Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: 110,
                            child: Column(
                              children: [
                                SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(CupertinoIcons.person,
                                        color: /*Color(0xff272727)*/ Colors
                                            .white
                                            .withOpacity(1),
                                        size: 40),
                                    SizedBox(width: 10),
                                    Text(
                                        userData.username == null
                                            ? "loading..."
                                            : userData.username,
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
                                        color: Colors.white)),
                                SizedBox(height: 5),
                                Text(
                                    "TAKES REMAINING: " +
                                        userData.picksRemaining.toString(),
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
                              if (userData.picksRemaining > 0) select(1);
                            },
                            child: GameButton(
                                top: true,
                                city: Teams().cityFromInitials(game1.team1),
                                team: Teams().teamFromInitials(game1.team1),
                                subtitle: game1.subtitle1,
                                logo: Teams().logoFromInitials(game1.team1),
                                odds: game1.odds1,
                                selected: this._team1status ? true : false,
                                submitted:
                                    this._team1submission ? true : false)),
                        Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.3))),
                        InkWell(
                            onTap: () {
                              if (userData.picksRemaining > 0) select(2);
                            },
                            child: GameButton(
                                top: false,
                                city: Teams().cityFromInitials(game1.team2),
                                team: Teams().teamFromInitials(game1.team2),
                                subtitle: game1.subtitle2,
                                logo: Teams().logoFromInitials(game1.team2),
                                odds: game1.odds2,
                                selected: this._team2status ? true : false,
                                submitted:
                                    this._team2submission ? true : false)),
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
                              if (userData.picksRemaining > 0) select(3);
                            },
                            child: GameButton(
                                top: true,
                                city: Teams().cityFromInitials(game2.team1),
                                team: Teams().teamFromInitials(game2.team1),
                                subtitle: game2.subtitle1,
                                logo: Teams().logoFromInitials(game2.team1),
                                odds: game2.odds1,
                                selected: this._team3status ? true : false,
                                submitted:
                                    this._team3submission ? true : false)),
                        Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.3))),
                        InkWell(
                            onTap: () {
                              if (userData.picksRemaining > 0) select(4);
                            },
                            child: GameButton(
                              top: false,
                              city: Teams().cityFromInitials(game2.team2),
                              team: Teams().teamFromInitials(game2.team2),
                              subtitle: game2.subtitle2,
                              logo: Teams().logoFromInitials(game2.team2),
                              odds: game2.odds2,
                              selected: this._team4status ? true : false,
                              submitted: this._team4submission ? true : false,
                            )),
                        SizedBox(height: hasPicked() ? 22 : 32),
                        Container(
                          width: 280,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: userData.picksRemaining > 0
                                  ? LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                          Color(0xffFF6400),
                                          Colors.red[600]
                                        ])
                                  : LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                          Color(0xffededed),
                                          Color(0xffc9c9c9)
                                        ])),
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
                                  Icon(FireIcon.fire,
                                      size: 30, color: Color(0xff272727))
                                ],
                              ),
                              onPressed: hasPicked()
                                  ? () async {
                                      if (userData.picksRemaining > 0) {
                                        await DatabaseService(uid: user.uid)
                                            .decrementUserPicks(user.uid,
                                                userData.picksRemaining);
                                        int gameNum =
                                            getSubmissionIndex() > 2 ? 2 : 1;
                                        int teamNum =
                                            getSubmissionIndex() % 2 == 0
                                                ? 2
                                                : 1;
                                        String opponentTeam =
                                            getSubmissionIndex() < 2
                                                ? getSubmissionIndex() == 0
                                                    ? game1.team1
                                                    : game1.team2
                                                : getSubmissionIndex() == 2
                                                    ? game2.team1
                                                    : game2.team2;
                                        String pickedTeam =
                                            getSubmissionIndex() < 2
                                                ? getSubmissionIndex() == 1
                                                    ? game1.team1
                                                    : game1.team2
                                                : getSubmissionIndex() == 3
                                                    ? game2.team1
                                                    : game2.team2;
                                        await DatabaseService().submitPick(
                                            userData.uid,
                                            Gamemanager().getGameID(gameNum),
                                            teamNum,
                                            pickedTeam,
                                            opponentTeam,
                                            getSubmissionIndex());
                                        setState(() {
                                          submit(getSubmissionIndex());
                                          this._team1status = false;
                                          this._team2status = false;
                                          this._team3status = false;
                                          this._team4status = false;
                                          this.buttonEnabled = false;
                                          /*switch (getSubmissionIndex()) {
                                            case 1:
                                              this._team1submission = true;
                                              break;
                                            case 2:
                                              this._team2submission = true;
                                              break;
                                            case 3:
                                              this._team3submission = true;
                                              break;
                                            case 4:
                                              this._team4submission = true;
                                              break;
                                            default:
                                              break;
                                          }*/
                                        });
                                      }
                                    }
                                  : null),
                        )
                      ]));
                    } else
                      return Container();
                  });
            } else
              return Container();
          }),
    );
  }
}
