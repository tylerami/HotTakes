import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hottakes1/services/database.dart';
import 'package:hottakes1/services/gamemanager.dart';
import 'package:hottakes1/services/teams.dart';
import 'package:provider/provider.dart';

class GameViewer extends StatefulWidget {
  @override
  _GameViewerState createState() => _GameViewerState();
}

class _GameViewerState extends State<GameViewer> {
  String yy = '';
  String mm = '';
  String dd = '';
  String date = '';

  final _searchGamesKey = GlobalKey<FormState>();

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
                          key: _searchGamesKey,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    child: TextFormField(
                                        validator: (val) => val.isEmpty
                                            ? "Year is empty"
                                            : null,
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
                                        validator: (val) => val.isEmpty
                                            ? "Month is empty"
                                            : null,
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
                              CupertinoButton(
                                  child: Container(
                                    width: 120,
                                    height: 50,
                                    color: Colors.blueAccent,
                                    child: Center(
                                      child: Text('Search Games',
                                          style: GoogleFonts.roboto(
                                              color: Colors.white)),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_searchGamesKey.currentState
                                        .validate()) {
                                      setState(() {
                                        date = yy + ' ' + mm + ' ' + dd;
                                      });
                                    }
                                  })
                            ],
                          ),
                        ),
                        FutureProvider<List<Game>>.value(
                            value: DatabaseService().getGamesOnDay(date),
                            builder: (context, child) {
                              final gameList = Provider.of<List<Game>>(context);
                              if (gameList == null || gameList.length == 0)
                                return Container();
                              else {
                                return SafeArea(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: gameList.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          contentPadding: EdgeInsets.all(5),
                                          title: Text(gameList[index].gameID),
                                          subtitle: gameList[index]
                                                      .team1score ==
                                                  ''
                                              ? Text(Teams().teamFromInitials(
                                                      gameList[index].team1) +
                                                  ' vs ' +
                                                  Teams().teamFromInitials(
                                                      gameList[index].team2))
                                              : Text(Teams().teamFromInitials(
                                                      gameList[index].team1) +
                                                  ' (' +
                                                  gameList[index].team1score +
                                                  ') vs ' +
                                                  Teams().teamFromInitials(
                                                      gameList[index].team2) +
                                                  ' (' +
                                                  gameList[index].team2score +
                                                  ')'),
                                          trailing: Text('ODDS: ' +
                                              gameList[index].odds1 +
                                              ' // ' +
                                              gameList[index].odds2),
                                        );
                                      }),
                                );
                              }
                            }),
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
