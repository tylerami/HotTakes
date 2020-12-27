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
          List<TakeCard> streakList = [];
          for (var pick in picks) {
            Game game;
            for (var g in games) {
              if (g.gameID == pick.gameID) {
                game = g;
                cardList.add(TakeCard().createTakeCard(game, pick));
              }
            }
          }

          if (cardList.length > 0 && user.uid != null) {
            int counter = 0;
            int i = 1;
            bool on = true;
            if (cardList[cardList.length - 1].pickedRight == 1) {
              streakList.add(cardList[cardList.length - 1]);
              counter++;
            }
            if (cardList[cardList.length - 1].pickedRight == 2) on = false;
            while (on && i <= cardList.length - 1) {
              if (cardList[cardList.length - 1 - i].pickedRight == 1) {
                streakList.add(cardList[cardList.length - 1 - i]);
                counter++;
                i++;
              } else {
                on = false;
              }
            }
            if (streakList.length > 1) {
              for (i = 0; i <= counter - 1; i++) {
                if (TakeCard().pickedOnConsecutiveDays(
                    streakList[i], streakList[i + 1])) counter = 0;
              }
            }
            DatabaseService().setUserStreak(user.uid, counter);
          }
          return ListView.builder(
              itemCount: cardList.length,
              itemBuilder: (context, index) {
                if (games != null && picks != null) {
                  return Container(
                      child: cardList[cardList.length - 1 - index]);
                } else
                  return Container();
              });
        });
  }
}
