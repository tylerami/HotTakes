import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hottakes1/services/database.dart';
import 'package:hottakes1/services/gamemanager.dart';
import 'package:hottakes1/services/teams.dart';
import 'package:provider/provider.dart';

class UnfinishedGames extends StatefulWidget {
  @override
  _UnfinishedGamesState createState() => _UnfinishedGamesState();
}

class _UnfinishedGamesState extends State<UnfinishedGames> {
  String yy = '';
  String mm = '';
  String dd = '';
  String date = '';
  bool active = false;

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
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width - 30,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 50),
                            CupertinoButton(
                                child: Container(
                                  width: 180,
                                  height: 50,
                                  color: Colors.blueAccent,
                                  child: Center(
                                    child: Text('Show unfinished games',
                                        style: GoogleFonts.roboto(
                                            color: Colors.white)),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    active = true;
                                  });
                                }),
                            FutureProvider<List<Game>>.value(
                                value: DatabaseService().showUnfinishedGames(),
                                builder: (context, child) {
                                  final gameList =
                                      Provider.of<List<Game>>(context);
                                  if (gameList == null || gameList.length == 0)
                                    return Container();
                                  else if (active) {
                                    return SafeArea(
                                      child: Container(
                                        height: 600,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: gameList.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                title: Text(
                                                    gameList[index].gameID),
                                                subtitle: Text(Teams()
                                                        .teamFromInitials(
                                                            gameList[index]
                                                                .team1) +
                                                    ' vs ' +
                                                    Teams().teamFromInitials(
                                                        gameList[index].team2)),
                                                trailing: Text('ODDS: ' +
                                                    gameList[index].odds1 +
                                                    ' // ' +
                                                    gameList[index].odds2),
                                              );
                                            }),
                                      ),
                                    );
                                  } else
                                    return Container();
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
            ),
          ),
        ));
  }
}
