import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hottakes1/services/database.dart';
import 'package:hottakes1/services/gamemanager.dart';
import 'package:hottakes1/services/teams.dart';
import 'package:provider/provider.dart';

class UpdateOdds extends StatefulWidget {
  @override
  _UpdateOddsState createState() => _UpdateOddsState();
}

class _UpdateOddsState extends State<UpdateOdds> {
  String gameId = '';
  String odds1 = '';
  String odds2 = '';
  String success2 = '';
  final _updateOddsKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Localizations(
            locale: const Locale('en', 'US'),
            delegates: <LocalizationsDelegate<dynamic>>[
              DefaultWidgetsLocalizations.delegate,
              DefaultMaterialLocalizations.delegate,
            ],
            child: Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width - 30,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: _updateOddsKey,
                          child: Column(
                            children: [
                              TextFormField(
                                  validator: (val) =>
                                      val.isEmpty ? "Game ID is empty" : null,
                                  decoration:
                                      InputDecoration(hintText: 'Game ID*'),
                                  onChanged: (val) {
                                    setState(() => gameId = val);
                                  }),
                              TextFormField(
                                  keyboardType: TextInputType.datetime,
                                  validator: (val) => val.isEmpty
                                      ? "Team 1 odds is empty"
                                      : null,
                                  decoration:
                                      InputDecoration(hintText: 'Team 1 odds'),
                                  onChanged: (val) {
                                    setState(() => odds1 = val);
                                  }),
                              TextFormField(
                                  keyboardType: TextInputType.datetime,
                                  validator: (val) => val.isEmpty
                                      ? "Team 2 odds is empty"
                                      : null,
                                  decoration:
                                      InputDecoration(hintText: 'Team 2 Odds'),
                                  onChanged: (val) {
                                    setState(() => odds2 = val);
                                  }),
                              CupertinoButton(
                                  child: Container(
                                    width: 120,
                                    height: 50,
                                    color: Colors.blueAccent,
                                    child: Center(
                                      child: Text('Submit New Odds',
                                          style: GoogleFonts.roboto(
                                              color: Colors.white)),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_updateOddsKey.currentState
                                        .validate()) {
                                      dynamic result = await DatabaseService()
                                          .updateOdds(gameId, odds1, odds2);
                                      if (result == null) {
                                        setState(() {
                                          success2 =
                                              "Successfully submitted winner";
                                        });

                                        Future.delayed(
                                            const Duration(milliseconds: 200),
                                            () {
                                          setState(() {
                                            success2 = '';
                                          });
                                        });
                                      }
                                    }
                                  }),
                            ],
                          ),
                        ),
                        Text(success2,
                            style: GoogleFonts.roboto(
                                color: Colors.green, fontSize: 12)),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xff2F2F2F)),
                              child: Icon(Icons.arrow_back_ios_rounded,
                                  color: Colors.white.withOpacity(.6),
                                  size: 25)),
                        )
                      ])),
            )));
  }
}
