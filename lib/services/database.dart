import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hottakes1/models/user.dart';
import 'package:hottakes1/services/gamemanager.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference gamesCollection =
      FirebaseFirestore.instance.collection('games');
  final CollectionReference userPicksCollection =
      FirebaseFirestore.instance.collection('userPicks');
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('userData');
  final CollectionReference userDeliveryCollection =
      FirebaseFirestore.instance.collection('userDelivery');

  Future updateUserData(String uid, String username, String league1,
      String league2, int streak, int picksRemaining) async {
    await updateUserGames(uid);
    return await userDataCollection.doc(uid).set({
      'uid': uid,
      'username': username,
      'league1': league1,
      'league2': league2,
      'streak': streak,
      'picksRemaining': picksRemaining,
      'date': Gamemanager().getDate()
    });
  }

  //get data stream
  Stream<UserData> get userData {
    return userDataCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future updateUserGames(String uid) async {
    DocumentSnapshot snap = await userDataCollection.doc(uid).get();
    UserData userData = _userDataFromSnapshot(snap);
    if (userData.date.toString() != Gamemanager().getDate()) {
      int game1 = Random().nextInt(2);
      int game2 = game1;
      while (game1 == game2) {
        game2 = Random().nextInt(2);
      }
      return await userDataCollection.doc(uid).set(
          {'date': Gamemanager().getDate(), 'game1': game1, 'game2': game2});
    }
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot doc) {
    return UserData(
        uid: doc.data()['uid'],
        username: doc.data()['username'],
        league1: doc.data()['league1'],
        league2: doc.data()['league2'],
        streak: doc.data()['streak'],
        picksRemaining: doc.data()['picksRemaining'],
        date: doc.data()['date'],
        game1: doc.data()['game1'],
        game2: doc.data()['game2']);
  }

  Future setGame(
      int year,
      int month,
      int day,
      int game,
      String team1,
      String team2,
      String odds1,
      String odds2,
      String subtitle1,
      String subtitle2) async {
    String docID = year.toString() +
        ' ' +
        month.toString() +
        ' ' +
        day.toString() +
        ' G' +
        game.toString();
    return await gamesCollection.doc(docID).set({
      'team1': team1,
      'team2': team2,
      'odds1': odds1,
      'odds2': odds2,
      'subtitle1': subtitle1,
      'subtitle2': subtitle2
    });
  }

  Future setGameToday(int game, String team1, String team2, String odds1,
      String odds2, String subtitle1, String subtitle2) async {
    String docID = Gamemanager().getGameID(game);
    return await gamesCollection.doc(docID).set({
      'team1': team1,
      'team2': team2,
      'odds1': odds1,
      'odds2': odds2,
      'subtitle1': subtitle1,
      'subtitle2': subtitle2
    });
  }

  Game getGame(int gameNum) {
    String docID = Gamemanager().getGameID(gameNum);
    Game game;
    gamesCollection
        .doc(docID)
        .get()
        .then((doc) => game = _gameFromSnapshot(doc));
    return game;
  }

  Future<Game> getGameV1(int gameNum) async {
    String docID = Gamemanager().getGameID(gameNum);
    DocumentSnapshot doc = await gamesCollection.doc(docID).get();
    return _gameFromSnapshot(doc);
  }

  Future<GamePair> getGames(int gameNum1, int gameNum2) async {
    String docID1 = Gamemanager().getGameID(gameNum1);
    String docID2 = Gamemanager().getGameID(gameNum2);
    DocumentSnapshot doc1 = await gamesCollection.doc(docID1).get();
    DocumentSnapshot doc2 = await gamesCollection.doc(docID2).get();
    return new GamePair(
        game1: _gameFromSnapshot(doc1), game2: _gameFromSnapshot(doc2));
  }

  Game _gameFromSnapshot(DocumentSnapshot doc) {
    return Game(
        team1: doc.data()['team1'],
        team2: doc.data()['team2'],
        odds1: doc.data()['odds1'],
        odds2: doc.data()['odds2'],
        subtitle1: doc.data()['subtitle1'],
        subtitle2: doc.data()['subtitle2']);
  }
}
