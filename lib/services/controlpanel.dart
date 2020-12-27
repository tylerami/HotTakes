import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hottakes1/services/database.dart';
import 'package:hottakes1/services/gamemanager.dart';

class ControlPanel extends StatefulWidget {
  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  final _newGameFormKey = GlobalKey<FormState>();
  final _gameWinnerFormKey = GlobalKey<FormState>();
  String yy = '';
  String mm = '';
  String dd = '';
  String gameID = '';
  String team1 = '';
  String team2 = '';
  String subtitle1 = '';
  String subtitle2 = '';
  String odds1 = '';
  String odds2 = '';

  String team1score = '';
  String team2score = '';
  String winner = '';

  String success1 = '';
  String success2 = '';

  @override
  Widget build(BuildContext context) {
    String date = Gamemanager().getDate();
    int year = int.parse(date[0].toString() + date[1].toString());
    int month = int.parse(date[3].toString() + date[4].toString());
    int day = int.parse(date[6].toString() + date[7].toString());
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
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Form(
                      key: _newGameFormKey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 50,
                                child: TextFormField(
                                    validator: (val) =>
                                        val.isEmpty ? "Year is empty" : null,
                                    keyboardType: TextInputType.datetime,
                                    decoration:
                                        InputDecoration(hintText: 'YY*'),
                                    onChanged: (val) {
                                      setState(() => yy = val);
                                    }),
                              ),
                              SizedBox(
                                width: 50,
                                child: TextFormField(
                                    keyboardType: TextInputType.datetime,
                                    validator: (val) =>
                                        val.isEmpty ? "Month is empty" : null,
                                    decoration:
                                        InputDecoration(hintText: 'MM*'),
                                    onChanged: (val) {
                                      setState(() => mm = val);
                                    }),
                              ),
                              SizedBox(
                                width: 50,
                                child: TextFormField(
                                    keyboardType: TextInputType.datetime,
                                    validator: (val) =>
                                        val.isEmpty ? "Day is empty" : null,
                                    decoration:
                                        InputDecoration(hintText: 'DD*'),
                                    onChanged: (val) {
                                      setState(() => dd = val);
                                    }),
                              ),
                            ],
                          ),
                          TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? "Team 1 code is empty" : null,
                              decoration:
                                  InputDecoration(hintText: 'Team 1 code*'),
                              onChanged: (val) {
                                setState(() => team1 = val);
                              }),
                          TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? "Team 2 code is empty" : null,
                              decoration:
                                  InputDecoration(hintText: 'Team 2 code*'),
                              onChanged: (val) {
                                setState(() => team2 = val);
                              }),
                          TextFormField(
                              validator: (val) =>
                                  subtitle2.isEmpty && subtitle1.isNotEmpty
                                      ? "Other subtitle is empty"
                                      : null,
                              decoration:
                                  InputDecoration(hintText: 'Team 1 subtitle'),
                              onChanged: (val) {
                                setState(() => subtitle1 = val);
                              }),
                          TextFormField(
                              validator: (val) =>
                                  subtitle1.isEmpty && subtitle2.isNotEmpty
                                      ? "Other subtitle is empty"
                                      : null,
                              decoration:
                                  InputDecoration(hintText: 'Team 2 subtitle'),
                              onChanged: (val) {
                                setState(() => subtitle2 = val);
                              }),
                          TextFormField(
                              validator: (val) =>
                                  odds2.isEmpty && odds1.isNotEmpty
                                      ? "Other score is empty"
                                      : null,
                              decoration:
                                  InputDecoration(hintText: 'Team 1 odds'),
                              onChanged: (val) {
                                setState(() => odds1 = val);
                              }),
                          TextFormField(
                              validator: (val) =>
                                  odds1.isEmpty && odds2.isNotEmpty
                                      ? "Other score is empty"
                                      : null,
                              decoration:
                                  InputDecoration(hintText: 'Team 2 odds'),
                              onChanged: (val) {
                                setState(() => odds2 = val);
                              }),
                          CupertinoButton(
                              child: Container(
                                width: 120,
                                height: 50,
                                color: Colors.blueAccent,
                                child: Center(
                                  child: Text('Submit Game',
                                      style: GoogleFonts.roboto(
                                          color: Colors.white)),
                                ),
                              ),
                              onPressed: () async {
                                if (_newGameFormKey.currentState.validate()) {
                                  dynamic result = await DatabaseService()
                                      .setGameAuto(
                                          int.parse(yy),
                                          int.parse(mm),
                                          int.parse(dd),
                                          team1,
                                          team2,
                                          odds1,
                                          odds2,
                                          subtitle1,
                                          subtitle2);
                                  if (result != null) {
                                    setState(() {
                                      success1 = "Successfully submitted game";
                                    });

                                    Future.delayed(
                                        const Duration(milliseconds: 20000),
                                        () {
                                      setState(() {
                                        success1 = '';
                                      });
                                    });
                                  }
                                }
                              }),
                          Text(success1,
                              style: GoogleFonts.roboto(
                                  color: Colors.green, fontSize: 12))
                        ],
                      ),
                    ),
                    Form(
                      key: _gameWinnerFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? "Game ID is empty" : null,
                              decoration: InputDecoration(hintText: 'Game ID*'),
                              onChanged: (val) {
                                setState(() => gameID = val);
                              }),
                          TextFormField(
                              keyboardType: TextInputType.datetime,
                              validator: (val) =>
                                  team2score.isEmpty && team1score.isNotEmpty
                                      ? "Other score is empty"
                                      : null,
                              decoration:
                                  InputDecoration(hintText: 'Team 1 Score'),
                              onChanged: (val) {
                                setState(() => team1score = val);
                              }),
                          TextFormField(
                              keyboardType: TextInputType.datetime,
                              validator: (val) =>
                                  team2score.isNotEmpty && team1score.isEmpty
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
                              decoration:
                                  InputDecoration(hintText: 'Winner (1 or 2)'),
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
                                  if (result != null) {
                                    setState(() {
                                      success2 =
                                          "Successfully submitted winner";
                                    });

                                    Future.delayed(
                                        const Duration(milliseconds: 20000),
                                        () {
                                      setState(() {
                                        success2 = '';
                                      });
                                    });
                                  }
                                }
                              }),
                          Text(success2,
                              style: GoogleFonts.roboto(
                                  color: Colors.green, fontSize: 12))
                        ],
                      ),
                    ),
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
                              color: Colors.white.withOpacity(.6), size: 25)),
                    )
                  ],
                )),
              ),
            )));
  }
}
