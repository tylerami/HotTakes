import 'package:flutter/material.dart';
import 'package:hottakes1/models/pick.dart';
import 'package:hottakes1/models/user.dart';
import 'package:hottakes1/services/database.dart';
import 'package:hottakes1/services/gamemanager.dart';

import 'takecard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class TakesList extends StatefulWidget {
  @override
  _TakesListState createState() => _TakesListState();
}

class _TakesListState extends State<TakesList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return StreamProvider<List<Game>>.value(
        value: DatabaseService(uid: user.uid).games,
        builder: (context, child) {
          final games = Provider.of<List<Game>>(context) ?? [];
          final picks = Provider.of<List<Pick>>(context) ?? [];
          List<TakeCard> cardList = [];
          for (var pick in picks) {
            Game game;
            for (var g in games) {
              if (g.gameID == pick.gameID) {
                game = g;
                cardList.add(TakeCard().createTakeCard(game, pick));
              }
            }
          }
          return ListView.builder(
              itemCount: cardList.length,
              itemBuilder: (context, index) {
                if (games != null && picks != null)
                  return Container(
                      child: cardList[cardList.length - 1 - index]);
                else
                  return Container();
              });
        });
  }
}
