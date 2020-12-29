import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hottakes1/models/pick.dart';
import 'package:hottakes1/models/user.dart';
import 'package:hottakes1/services/database.dart';
import 'package:hottakes1/services/gamemanager.dart';
import 'package:hottakes1/services/teams.dart';
import 'package:provider/provider.dart';

class FriendTile extends StatefulWidget {
  final String username;
  final bool areFriends;
  final String streak;

  FriendTile({this.username, this.areFriends, this.streak});

  Future<FriendTile> createFriendTile(String username, bool areFriends) async {
    return FriendTile(
        streak: streak, username: username, areFriends: areFriends);
  }

  @override
  _FriendTileState createState() => _FriendTileState();
}

class _FriendTileState extends State<FriendTile> {
  String pickedTeam;
  String opponentTeam;
  int pickedRight;
  String pickedScore;
  String opponentScore;
  String date;
  String streak;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return FutureProvider<Pick>.value(
        value: DatabaseService().pickFromUsername(widget.username),
        builder: (context, child) {
          Pick pick = Provider.of<Pick>(context) ?? null;
          List<Game> gamesList = Provider.of<List<Game>>(context) ?? [];
          Game game;
          if (gamesList == null || pick == null)
            return Container();
          else {
            for (int i = 0; i < gamesList.length; i++) {
              if (gamesList != null && pick != null) {
                if (gamesList[i].gameID == pick.gameID) game = gamesList[i];
              }
            }
            if (pick == null || gamesList == null)
              return Container();
            else {
              date = game.gameID[0] +
                  game.gameID[1] +
                  '/' +
                  game.gameID[3] +
                  game.gameID[4] +
                  '/' +
                  game.gameID[6] +
                  game.gameID[7];
              pickedRight = game.winner == 0
                  ? 0
                  : game.winner == pick.team
                      ? 1
                      : 2;
              pickedScore = pick.team == 1 ? game.team1score : game.team2score;
              opponentScore =
                  pick.team == 1 ? game.team2score : game.team1score;
              pickedTeam = pick.team == 1 ? game.team1 : game.team2;
              opponentTeam = pick.team != 1 ? game.team1 : game.team2;
              return Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  height: 120,
                  width: 500,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff141414),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 5,
                            offset: Offset(5, 5))
                      ]),
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(width: 20),
                          Text(widget.username,
                              style: GoogleFonts.oswald(
                                  color: Colors.white.withOpacity(.95),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 26)),
                          Spacer(flex: 1),
                          Column(
                            children: [SizedBox(height: 5)],
                          ),
                          Spacer(flex: 1),
                          widget.areFriends == false
                              ? FlatButton(
                                  onPressed: () {
                                    DatabaseService()
                                        .addFriend(user.uid, widget.username);
                                  },
                                  child: Text('Add Friend',
                                      style: GoogleFonts.roboto(
                                          color: CupertinoColors.activeBlue,
                                          fontSize: 12)))
                              : FlatButton(
                                  onPressed: () {
                                    DatabaseService().removeFriend(
                                        user.uid, widget.username);
                                  },
                                  child: Text('Remove Friend',
                                      style: GoogleFonts.roboto(
                                          color: CupertinoColors.destructiveRed,
                                          fontSize: 12))),
                        ]),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 1,
                            color: Colors.white.withOpacity(0.3),
                            width: 350,
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 20),
                        Text('Last Pick:  ',
                            style: GoogleFonts.roboto(
                                color: Colors.white.withOpacity(.85),
                                fontWeight: FontWeight.w700,
                                fontSize: 12)),
                        Spacer(),
                        Center(
                          child: Column(children: [
                            Text('Current Streak: ' + widget.streak,
                                style: GoogleFonts.roboto(
                                    color: Colors.white.withOpacity(.85),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12)),
                            Text(
                                pickedRight == 0
                                    ? Teams().teamFromInitials(pickedTeam) +
                                        ' over ' +
                                        Teams().teamFromInitials(opponentTeam)
                                    : Teams().teamFromInitials(pickedTeam) +
                                        ' (' +
                                        pickedScore +
                                        ') over ' +
                                        Teams().teamFromInitials(opponentTeam) +
                                        ' (' +
                                        opponentScore +
                                        ')',
                                style: GoogleFonts.oswald(
                                    color: pickedRight == 0
                                        ? Colors.white
                                        : pickedRight == 1
                                            ? Colors.green
                                            : Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                            Text(date,
                                style: GoogleFonts.roboto(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300))
                          ]),
                        ),
                        Spacer(),
                        SizedBox(
                            child: pickedRight != 0
                                ? pickedRight == 1
                                    ? Icon(CupertinoIcons.check_mark,
                                        size: 25, color: Colors.green)
                                    : Icon(CupertinoIcons.xmark,
                                        size: 25, color: Colors.red)
                                : Container()),
                        SizedBox(width: 40)
                      ],
                    ),
                  ]),
                ),
              );
            }
          }
        });
  }
}
