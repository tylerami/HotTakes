import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hottakes1/services/database.dart';
import 'package:hottakes1/services/gamemanager.dart';
import 'package:hottakes1/services/teams.dart';
import 'package:provider/provider.dart';

class SetWinner extends StatefulWidget {
  @override
  _SetWinnerState createState() => _SetWinnerState();
}

class _SetWinnerState extends State<SetWinner> {
  String gameID = '';

  String team1score = '';
  String team2score = '';
  String winner = '';

  String success2 = '';

  final _gameWinnerFormKey = GlobalKey<FormState>();

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
                          key: _gameWinnerFormKey,
                          child: Column(
                            children: [
                              TextFormField(
                                  validator: (val) =>
                                      val.isEmpty ? "Game ID is empty" : null,
                                  decoration:
                                      InputDecoration(hintText: 'Game ID*'),
                                  onChanged: (val) {
                                    setState(() => gameID = val);
                                  }),
                              TextFormField(
                                  keyboardType: TextInputType.datetime,
                                  validator: (val) => team2score.isEmpty &&
                                          team1score.isNotEmpty
                                      ? "Other score is empty"
                                      : null,
                                  decoration:
                                      InputDecoration(hintText: 'Team 1 Score'),
                                  onChanged: (val) {
                                    setState(() => team1score = val);
                                  }),
                              TextFormField(
                                  keyboardType: TextInputType.datetime,
                                  validator: (val) => team2score.isNotEmpty &&
                                          team1score.isEmpty
                                      ? "Other score is empty"
                                      : null,
                                  decoration:
                                      InputDecoration(hintText: 'Team 2 Score'),
                                  onChanged: (val) {
                                    setState(() => team2score = val);
                                  }),
                              TextFormField(
                                  keyboardType: TextInputType.datetime,
                                  validator: (val) =>
                                      val.isEmpty ? "Winner is empty" : null,
                                  decoration: InputDecoration(
                                      hintText: 'Winner (1 or 2)'),
                                  onChanged: (val) {
                                    setState(() => winner = val);
                                  }),
                              CupertinoButton(
                                  child: Container(
                                    width: 120,
                                    height: 50,
                                    color: Colors.blueAccent,
                                    child: Center(
                                      child: Text('Submit Winner',
                                          style: GoogleFonts.roboto(
                                              color: Colors.white)),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_gameWinnerFormKey.currentState
                                        .validate()) {
                                      dynamic result = await DatabaseService()
                                          .setGameWinner(gameID, team1score,
                                              team2score, int.parse(winner));
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
                      ]))),
        ));
  }
}
