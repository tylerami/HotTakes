import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:hottakes1/fire_icon_icons.dart' as FireIcon;

class GameButton extends StatelessWidget {
  GameButton(
      {this.top,
      this.city,
      this.team,
      this.subtitle,
      this.logo,
      this.selected,
      this.odds});
  final bool top;
  final String team;
  final String city;
  final String subtitle;
  final String logo;
  final String odds;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: !this.selected
          ? Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xff272727),
                  borderRadius: this.top
                      ? BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))
                      : BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(this.city,
                              style: GoogleFonts.oswald(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          Text(this.team,
                              style: GoogleFonts.oswald(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700)),
                          Text(this.subtitle,
                              style: GoogleFonts.oswald(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 5)
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(this.logo, height: 30),
                        Text(this.odds,
                            style: GoogleFonts.oswald(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                        SizedBox(height: 5)
                      ],
                    )
                  ],
                ),
              ),
              // SELECTED CONTAINER
            )
          : Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xffFF930F), Color(0xffFFF95B)]),
                  //color: Color(0xff570909),
                  borderRadius: this.top
                      ? BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))
                      : BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(this.city,
                              style: GoogleFonts.oswald(
                                  color: Color(0xff272727),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)),
                          Text(this.team,
                              style: GoogleFonts.oswald(
                                  color: Color(0xff272727),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700)),
                          Text(this.subtitle,
                              style: GoogleFonts.oswald(
                                  color: Color(0xff272727),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 5)
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(this.logo, height: 30),
                        Text(this.odds,
                            style: GoogleFonts.oswald(
                                color: Color(0xff272727), //Color(0xff272727),
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                        SizedBox(height: 5)
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 60,
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
                      Text('USERNAME',
                          style: GoogleFonts.oswald(
                              fontWeight: FontWeight.w600,
                              fontSize: 34,
                              color: Colors.white
                                  .withOpacity(1))), //Color(0xff272727))),
                      SizedBox(width: 8)
                    ],
                  ),
                  SizedBox(height: 1),
                  /*Container(
                      decoration: BoxDecoration(
                          color: Colors.red[800].withOpacity(.4)),
                      height: 1,
                      width: MediaQuery.of(context).size.width),
                  Text('Picks Remaining: 1',
                      style: GoogleFonts.oswald(
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.red[800])),
                  Text('Current Streak: 5',
                      style: GoogleFonts.oswald(
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.red[800])),*/
                  Container(
                    width: 350,
                    height: 1,
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(.2)),
                  )
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
                  city: 'DEN',
                  team: 'BRONCOS',
                  subtitle: '0-3-0, 4th AFC West',
                  logo: 'assets/denver.png',
                  odds: 'T:31.0',
                  selected: this._team1status ? true : false)),
          Container(
              height: 1,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(color: Colors.white.withOpacity(.3))),
          InkWell(
              onTap: () {
                select(2);
              },
              child: GameButton(
                  top: false,
                  city: 'NY',
                  team: 'JETS',
                  subtitle: '0-3-0, 4th AFC East',
                  logo: 'assets/jets.png',
                  odds: '-1.0',
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
                  city: 'LA',
                  team: 'DODGERS',
                  subtitle: '0-3-0, 4th AFC West',
                  logo: 'assets/la.png',
                  odds: 'T:31.0',
                  selected: this._team3status ? true : false)),
          Container(
              height: 1,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(color: Colors.white.withOpacity(.3))),
          InkWell(
              onTap: () {
                select(4);
              },
              child: GameButton(
                  top: false,
                  city: 'NY',
                  team: 'JETS',
                  subtitle: '0-3-0, 4th AFC East',
                  logo: 'assets/jets.png',
                  odds: '-1.0',
                  selected: this._team4status ? true : false)),
          SizedBox(height: hasPicked() ? 22 : 32),
          Container(
            width: 280,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xffFF930F), Color(0xffFFF95B)])),
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
          ),
        ],
      ),
    );
  }
}
