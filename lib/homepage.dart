import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:hottakes1/fire_icon_icons.dart' as FireIcon;

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class GameButton extends StatelessWidget {
  GameButton(
      {this.gameNumber,
      this.topCity,
      this.topTeam,
      this.topSubtitle,
      this.topLogo,
      this.topOdds,
      this.bottomCity,
      this.bottomTeam,
      this.bottomSubtitle,
      this.bottomLogo,
      this.bottomOdds,
      this.topColor,
      this.bottomColor});
  final int gameNumber;
  final String topCity;
  final String topTeam;
  final String topSubtitle;
  final String topLogo;
  final String topOdds;
  final String bottomCity;
  final String bottomTeam;
  final String bottomSubtitle;
  final String bottomLogo;
  final String bottomOdds;
  final Color topColor;
  final Color bottomColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 250, 10),
          child: Text('GAME ' + this.gameNumber.toString(),
              style: GoogleFonts.roboto(
                  color: Color(0xff777777),
                  fontSize: 14,
                  fontWeight: FontWeight.normal)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(0xff272727),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(this.topLogo, height: 30),
                      Text(this.topOdds,
                          style: GoogleFonts.oswald(
                              color: this.topColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 5)
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(this.topCity,
                          style: GoogleFonts.oswald(
                              color: this.topColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w400)),
                      Text(this.topTeam,
                          style: GoogleFonts.oswald(
                              color: this.topColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w700)),
                      Text(this.topSubtitle,
                          style: GoogleFonts.oswald(
                              color: this.topColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w200)),
                      SizedBox(height: 5)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
            height: 1,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(color: Colors.white.withOpacity(.3))),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(0xff272727),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 5),
                      Text(this.bottomCity,
                          style: GoogleFonts.oswald(
                              color: this.bottomColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w400)),
                      Text(this.bottomTeam,
                          style: GoogleFonts.oswald(
                              color: this.bottomColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w700)),
                      Text(this.bottomSubtitle,
                          style: GoogleFonts.oswald(
                              color: this.bottomColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w200))
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 5),
                      Image.asset(this.bottomLogo, height: 30),
                      Text(this.bottomOdds,
                          style: GoogleFonts.oswald(
                              color: this.bottomColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HomepageState extends State<Homepage> {
  final Color gameTextColor = Colors.white.withOpacity(0.9);
  final game1 = GameButton(
    gameNumber: 1,
    topCity: 'DEN',
    topTeam: 'BRONCOS',
    topLogo: 'assets/denver.png',
    topOdds: 'T:41.0',
    topSubtitle: '0-3-0, 4th AFC West',
    bottomCity: 'NY',
    bottomTeam: 'JETS',
    bottomLogo: 'assets/jets.png',
    bottomOdds: '-1.0',
    bottomSubtitle: '0-3-0, 4th AFC East',
  );

  Color _topColor1 = Colors.white;
  Color _topColor2 = Colors.white;
  Color _bottomColor1 = Colors.white;
  Color _bottomColor2 = Colors.white;

  void selectTeam(index) {
    setState(() {
      _topColor1 = Colors.white;
      _topColor2 = Colors.white;
      _bottomColor1 = Colors.white;
      _bottomColor2 = Colors.white;
      switch (index) {
        case 1:
          _topColor1 = Colors.green;
          break;
        case 2:
          _topColor2 = Colors.green;
          break;
        case 3:
          _bottomColor1 = Colors.green;
          break;
        case 4:
          _bottomColor2 = Colors.green;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(height: 15),
        Container(
            alignment: Alignment.center,
            width: 285,
            height: 104,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFFF95F03),
                  Color(0xffF94905),
                  Color(0xffB43100),
                  Color(0xffF94206)
                ], stops: [
                  0.0,
                  0.4,
                  0.401,
                  1.0
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.person, color: Color(0xff510000)),
                    SizedBox(width: 10),
                    Text('USERNAME',
                        style: GoogleFonts.oswald(
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                            color: Color(0xff510000)))
                  ],
                ),
                Text('PICKS REMAINING: 1',
                    style: GoogleFonts.oswald(
                        letterSpacing: 1.4,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Color(0xff510000))),
                Text('CURRENT STREAK: 5',
                    style: GoogleFonts.oswald(
                        letterSpacing: 1.4,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Color(0xff510000))),
              ],
            )),
        InkWell(
          onTap: () {
            setState(() {});
          },
          child: GameButton(
            gameNumber: 2,
            topCity: 'LA',
            topTeam: 'DODGERS',
            topLogo: 'assets/la.png',
            topOdds: '-230',
            topSubtitle: '43-17, 1st NL West',
            bottomCity: 'MIL',
            bottomTeam: 'BREWERS',
            bottomLogo: 'assets/brewers.png',
            bottomOdds: 'T:7.5',
            bottomSubtitle: '29-31, 4th NL Central',
            topColor: _topColor2,
            bottomColor: _bottomColor2,
          ),
        )
      ],
    ));
  }
}
