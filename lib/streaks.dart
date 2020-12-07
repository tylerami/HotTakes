import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:hottakes1/fire_icon_icons.dart' as FireIcon;

class Streaks extends StatefulWidget {
  @override
  _StreaksState createState() => _StreaksState();
}

class TakeCard extends StatelessWidget {
  TakeCard(
      {this.date,
      this.winningTeam,
      this.losingTeam,
      this.winningScore,
      this.losingScore,
      this.pickedRight,
      this.pickedWinner});
  final String date;
  final String winningTeam;
  final String losingTeam;
  final int winningScore;
  final int losingScore;
  final bool pickedRight;
  final bool pickedWinner;

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
                        Text(winningTeam,
                            style: GoogleFonts.oswald(
                                fontSize: 24,
                                color: pickedWinner
                                    ? (pickedRight ? Colors.green : Colors.red)
                                    : Colors.white,
                                fontWeight: FontWeight.w700)),
                        Text(losingTeam,
                            style: GoogleFonts.oswald(
                                fontSize: 24,
                                color: pickedWinner
                                    ? Colors.white
                                    : (pickedRight ? Colors.green : Colors.red),
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
                              Text(winningScore.toString(),
                                  style: GoogleFonts.oswald(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                              Text(losingScore.toString(),
                                  style: GoogleFonts.oswald(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300))
                            ]),
                        SizedBox(width: 10),
                        SizedBox(
                            child: pickedRight
                                ? Icon(CupertinoIcons.check_mark,
                                    size: 30, color: Colors.green)
                                : Icon(CupertinoIcons.xmark,
                                    size: 30, color: Colors.red)),
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

class _StreaksState extends State<Streaks> {
  List<Widget> getChildren() {
    return <Widget>[];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          TakeCard(
              date: '09/30/2020',
              winningTeam: 'RAYS',
              losingTeam: 'BLUEJAYS',
              winningScore: 8,
              losingScore: 2,
              pickedWinner: true,
              pickedRight: true),
          TakeCard(
              date: '09/29/2020',
              winningTeam: 'RAYS',
              losingTeam: 'BLUEJAYS',
              winningScore: 3,
              losingScore: 1,
              pickedWinner: true,
              pickedRight: true),
          TakeCard(
              date: '09/28/2020',
              winningTeam: 'LIGHTNING',
              losingTeam: 'STARS',
              winningScore: 2,
              losingScore: 0,
              pickedWinner: true,
              pickedRight: true),
          TakeCard(
              date: '09/27/2020',
              winningTeam: 'SEAHAWKS',
              losingTeam: 'COWBOYS',
              winningScore: 38,
              losingScore: 31,
              pickedWinner: true,
              pickedRight: true),
          TakeCard(
              date: '09/26/2020',
              winningTeam: 'LAKERS',
              losingTeam: 'NUGGETS',
              winningScore: 117,
              losingScore: 107,
              pickedWinner: true,
              pickedRight: true),
          TakeCard(
              date: '09/26/2020',
              winningTeam: 'CELTICS',
              losingTeam: 'HEAT',
              winningScore: 121,
              losingScore: 108,
              pickedWinner: false,
              pickedRight: false),
        ],
      ),
    );
  }
}
