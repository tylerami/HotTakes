import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:hottakes1/fire_icon_icons.dart' as FireIcon;
import 'package:hottakes1/models/user.dart';
import 'package:hottakes1/services/database.dart';
import 'package:hottakes1/settings.dart';
import 'package:provider/provider.dart';

class PrizeTier extends StatelessWidget {
  PrizeTier(
      {this.image,
      this.title,
      this.subtitle,
      this.wins,
      this.value,
      this.userWins});
  final int userWins;
  final String image;
  final String subtitle;
  final String title;
  final int wins;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
          height: 400,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffF7F7F7),
                    Color(0xffFFD3B6),
                    Color(0xffFF7F29)
                  ],
                  stops: [
                    0.0,
                    0.5,
                    1.0
                  ]),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(this.image), fit: BoxFit.fitWidth)),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(this.wins.toString() + ' WIN STREAK',
                    style: GoogleFonts.oswald(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.red[800])),
                Icon(FireIcon.FireIcon.fire, color: Colors.red[800])
              ]),
              SizedBox(height: 200),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  Column(children: [
                    Text(this.title,
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black,
                                  offset: Offset(5.0, 5.0))
                            ])),
                    SizedBox(height: 5),
                    /*this.subtitle == null
                        ? Text(this.subtitle,
                            style: GoogleFonts.roboto(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400))
                        : null,*/
                  ]),
                ],
              ),
              SizedBox(height: 30),
              SizedBox(
                width: 200,
                child: Container(
                  decoration: this.userWins >= this.wins
                      ? BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.6),
                              blurRadius: 10,
                              offset: Offset(4, 4))
                        ])
                      : BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(4, 4))
                        ]),
                  child: CupertinoButton(
                      padding: EdgeInsets.all(8),
                      borderRadius: BorderRadius.circular(15),
                      onPressed: this.userWins >= this.wins
                          ? () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          DeliveryForm(prizeIndex: wins)));
                            }
                          : null,
                      disabledColor: Colors.red[800].withOpacity(0.3),
                      color: Colors.red[800],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 20),
                          Text('CLAIM',
                              style: GoogleFonts.oswald(
                                  fontSize: 24,
                                  color: this.userWins >= this.wins
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.3),
                                  fontWeight: FontWeight.w600)),
                          SizedBox(width: 10),
                          Icon(CupertinoIcons.chevron_right,
                              color: this.userWins >= this.wins
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.3),
                              size: 30)
                        ],
                      )),
                ),
              ),
              SizedBox(height: 8)
            ],
          )),
    );
  }
}

class Prizes extends StatefulWidget {
  @override
  _PrizesState createState() => _PrizesState();
}

class _PrizesState extends State<Prizes> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return StreamProvider<UserData>.value(
        value: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          final userData = Provider.of<UserData>(context);
          if (userData != null) {
            return Center(
                child: ListView(
              shrinkWrap: true,
              children: [
                PrizeTier(
                    image: 'assets/merch.png',
                    title: 'HOT TAKES\nMUSCLE TEE',
                    wins: 4,
                    userWins: userData.streak),
                PrizeTier(
                    image: 'assets/beercard.png',
                    title: "\$100 BEERSTORE\nGIFTCARD",
                    wins: 10,
                    userWins: userData.streak),
                PrizeTier(
                    image: 'assets/tickets.png',
                    title: 'SPORTS TICKETS \n(\$600 VALUE)',
                    wins: 15,
                    userWins: userData.streak),
                PrizeTier(
                    image: 'assets/cash.png',
                    title: '\$10,000 CASH\n     ',
                    wins: 20,
                    userWins: userData.streak),
              ],
            ));
          } else
            return Container();
        });
  }
}
