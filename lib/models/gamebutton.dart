import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:hottakes1/fire_icon_icons.dart' as FireIcon;
import 'package:hottakes1/services/database.dart';
import 'package:provider/provider.dart';
import 'package:hottakes1/models/user.dart';

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(this.city,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.oswald(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          Text(this.team,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.oswald(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700)),
                          Text(this.subtitle,
                              textAlign: TextAlign.left,
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
