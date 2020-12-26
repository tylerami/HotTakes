import 'dart:ffi';

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
      this.odds,
      this.submitted});
  final bool top;
  final String team;
  final String city;
  final String subtitle;
  final String logo;
  final String odds;
  final bool selected;
  final bool submitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: !this.submitted
          ? Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: this.selected
                      ? LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Color(0xffFF930F), Color(0xffFFF95B)])
                      : null,
                  color: this.selected ? null : Color(0xff272727),
                  borderRadius: this.top
                      ? BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))
                      : BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 3),
                          Text(this.city,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.oswald(
                                  color: this.selected
                                      ? Color(0xff272727)
                                      : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          Text(this.team,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.oswald(
                                  color: this.selected
                                      ? Color(0xff272727)
                                      : Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700)),
                          Text(this.subtitle,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.oswald(
                                  color: this.selected
                                      ? Color(0xff272727)
                                      : Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 5)
                        ],
                      ),
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(this.logo, height: 30),
                          ],
                        ),
                        Text(this.odds,
                            style: GoogleFonts.oswald(
                                color: this.selected
                                    ? Color(0xff272727)
                                    : Colors.white,
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
                      end: Alignment.topRight,
                      begin: Alignment.bottomLeft,
                      colors: [Color(0xffb5b5b5), Color(0xfff0f0f0)]),
                  //color: Color(0xff570909),
                  borderRadius: this.top
                      ? BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))
                      : BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 3),
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
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 3),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [Image.asset(this.logo, height: 30)]),
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
