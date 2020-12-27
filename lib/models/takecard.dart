import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:hottakes1/models/pick.dart';
import 'package:hottakes1/services/gamemanager.dart';
import 'package:hottakes1/services/teams.dart';

class TakeCard extends StatelessWidget {
  TakeCard createTakeCard(Game game, Pick pick) {
    // doc = pick, gameDOc = game
    String pickedTeam = pick.team == 1 ? game.team1 : game.team2;
    String opponentTeam = pick.team != 1 ? game.team1 : game.team2;
    return TakeCard(
        date: game.gameID[0] +
            game.gameID[1] +
            '/' +
            game.gameID[3] +
            game.gameID[4] +
            '/' +
            game.gameID[6] +
            game.gameID[7],
        pickedTeam: Teams().teamFromInitials(pickedTeam),
        opponentTeam: Teams().teamFromInitials(opponentTeam),
        pickedTeamScore: pick.team == 1 ? game.team1score : game.team2score,
        opponentScore: pick.team == 1 ? game.team2score : game.team1score,
        pickedRight: game.winner == 0
            ? 0
            : game.winner == pick.team
                ? 1
                : 2);
  }

  bool pickedOnConsecutiveDays(TakeCard card1, TakeCard card2) {
    int year1 = int.parse(card1.date[0] + card1.date[1]);
    int month1 = int.parse(card1.date[3] + card1.date[4]);
    int day1 = int.parse(card1.date[6] + card1.date[7]);
    int year2 = int.parse(card2.date[0] + card2.date[1]);
    int month2 = int.parse(card2.date[3] + card2.date[4]);
    int day2 = int.parse(card2.date[6] + card2.date[7]);
    //different year true cases
    if (year1 == year2 - 1 || year1 == year2 + 1) {
      if (day1 == 31) {
        if (day2 == 1) return true;
      } else if (day2 == 31) {
        if (day1 == 1) {
          return true;
        }
      }
      //different month true cases
    } else if ((month1 == month2 - 1 || month1 == month2 + 1) &&
        (year1 == year2)) {
      if (day1 == 30 &&
          (month1 == 9 || month1 == 4 || month1 == 5 || month1 == 11)) {
        if (day2 == 1) return true;
      } else if (day2 == 30 &&
          (month2 == 9 || month2 == 4 || month2 == 5 || month2 == 11)) {
        if (day1 == 1) {
          return true;
        }
      } else if (day1 == 31) {
        if (day2 == 1) return true;
      } else if (day2 == 31) {
        if (day1 == 1) {
          return true;
        }
      }
    }
//different day true cases
    else if ((day1 == day2 - 1 || day1 == day2 + 1) &&
        (year1 == year2) &&
        (month1 == month2)) return true;
    return false;
  }

  TakeCard(
      {this.date,
      this.pickedTeam,
      this.opponentTeam,
      this.pickedTeamScore,
      this.opponentScore,
      this.pickedRight});
  final String date;
  final String pickedTeam;
  final String opponentTeam;
  final String pickedTeamScore;
  final String opponentScore;
  final int pickedRight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[900]),
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(date,
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500)),
                        Text(pickedTeam,
                            style: GoogleFonts.oswald(
                                fontSize: 24,
                                color: pickedRight != 0
                                    ? (pickedRight == 1
                                        ? Colors.green
                                        : Colors.white)
                                    : Colors.white,
                                fontWeight: FontWeight.w700)),
                        Text(opponentTeam,
                            style: GoogleFonts.oswald(
                                fontSize: 24,
                                color: pickedRight == 0
                                    ? Colors.white
                                    : (pickedRight == 2
                                        ? Colors.red
                                        : Colors.white),
                                fontWeight: FontWeight.w300)),
                      ]),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(height: 14),
                              Text(pickedTeamScore,
                                  style: GoogleFonts.oswald(
                                      fontSize: 20,
                                      color: pickedRight != 0
                                          ? (pickedRight == 1
                                              ? Colors.green
                                              : Colors.white)
                                          : Colors.white,
                                      fontWeight: FontWeight.w700)),
                              Text(opponentScore,
                                  style: GoogleFonts.oswald(
                                      fontSize: 20,
                                      color: pickedRight == 0
                                          ? Colors.white
                                          : (pickedRight == 2
                                              ? Colors.red
                                              : Colors.white),
                                      fontWeight: FontWeight.w300))
                            ]),
                        SizedBox(width: 10),
                        SizedBox(
                            child: pickedRight != 0
                                ? pickedRight == 1
                                    ? Icon(CupertinoIcons.check_mark,
                                        size: 30, color: Colors.green)
                                    : Icon(CupertinoIcons.xmark,
                                        size: 30, color: Colors.red)
                                : Container()),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
