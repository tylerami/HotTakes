import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hottakes1/models/pick.dart';
import 'package:hottakes1/models/takecard.dart';
import 'package:hottakes1/models/user.dart';
import 'package:hottakes1/services/gamemanager.dart';
import 'package:hottakes1/services/teams.dart';

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
    return await userDataCollection.doc(uid).set({
      'uid': uid,
      'username': username,
      'league1': league1,
      'league2': league2,
      'streak': streak,
      'picksRemaining': picksRemaining,
      'date': Gamemanager().getDate(),
      'game1': '',
      'game2': ' ',
      'currentPick': 0
    });
  }

  Future submitPick(String uid, String gameID, int team, String pickedTeam,
      String opponentTeam, int currentPick) async {
    int year = int.parse(gameID[0] + gameID[1]);
    int month = int.parse(gameID[3] + gameID[4]);
    int day = int.parse(gameID[6] + gameID[7]);
    await userDataCollection.doc(uid).update({'currentPick': currentPick});
    return await userDataCollection
        .doc(uid)
        .collection('picks')
        .doc(gameID)
        .set({
      'team': team,
      'gameID': gameID,
      'year': year,
      'month': month,
      'day': day,
      'pickedTeam': pickedTeam,
      'opponentTeam': opponentTeam
    });
  }

  Future decrementUserPicks(String uid, int currentVal) async {
    return await userDataCollection
        .doc(uid)
        .update({'picksRemaining': currentVal - 1});
  }

  /*Future<TakeCard> _futureTakeCardFromSnapshot(DocumentSnapshot doc) async {
    String gameID = doc.data()['gameID'];
    DocumentSnapshot gameDoc = await gamesCollection.doc(gameID).get();
    String pickedTeam = doc.data()['team'] == 1 ? gameDoc.data()['team1'] : gameDoc.data()['team2'];
    String opponentTeam = doc.data()['team'] == 1 ? gameDoc.data()['team1'] : gameDoc.data()['team2'];
    return TakeCard(date: gameID[0] + gameID[1] + '/' + gameID[3] + gameID[4] + '/' + gameID[6] + gameID[7],
      pickedTeam: Teams().teamFromInitials(pickedTeam),
      opponentTeam: Teams().teamFromInitials(opponentTeam),
      pickedTeamScore: doc.data()['team'] == 1 ? gameDoc.data()['team1score'] : gameDoc.data()['team2score'],
      opponentScore: doc.data()['team'] == 1 ? gameDoc.data()['team1score'] : gameDoc.data()['team2score'],
      pickedRight: gameDoc.data()['winner'] == 0 ? null : gameDoc.data()['winner'] == doc.data()['team'] ? true : false);
  }

  Stream<QuerySnapshot> get futureTakeCards {
    return userDataCollection.doc(uid).collection('picks').snapshots();
  }

  Future<DocumentSnapshot> getGame(String gameID) async {
    return await gamesCollection.doc(gameID).get();
  }


  Stream<List<DocumentSnapshot>> get takeSnapshots {
    List list = [];
    String date = Gamemanager().getDate();
    int year = int.parse(date[0] + date[1]);
    int month = int.parse(date[3] + date[4]);
    int day = int.parse(date[6] + date[7]);
    int i = 0;
    while (i<20){
      String date = year.toString() + ' ' + month.toString() + ' ' + day.toString(); 
      QuerySnapshot doc = userDataCollection.doc(uid).collection('picks').where('__name__', arrayContains: date).get();
      list.add()
    }
  }*/

  List<Pick> _pickSnapshotsToList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Pick(
          day: doc.data()['day'],
          month: doc.data()['month'],
          year: doc.data()['year'],
          gameID: doc.data()['gameID'],
          team: doc.data()['team']);
    }).toList();
  }

  Stream<List<Pick>> get picks {
    return userDataCollection
        .doc(uid)
        .collection('picks')
        .snapshots()
        .map(_pickSnapshotsToList);
  }

  List<Game> _gameSnapshotsToList(QuerySnapshot snap) {
    return snap.docs.map((doc) {
      return _gameFromSnapshot(doc);
    }).toList();
  }

  Stream<List<Game>> get games {
    return gamesCollection.snapshots().map(_gameSnapshotsToList);
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
      return await userDataCollection.doc(uid).update({
        'date': Gamemanager().getDate(),
        'game1': game1,
        'game2': game2,
        'picksRemaining': userData.picksRemaining + 1,
        'currentPick': 0
      });
    }
  }

  Future givePick(String uid) async {
    return await userDataCollection
        .doc(uid)
        .update({'picksRemaining': 1, 'currentPick': 0});
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
        game2: doc.data()['game2'],
        currentPick: doc.data()['currentPick']);
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
      'gameID': docID,
      'team1': team1,
      'team2': team2,
      'odds1': odds1,
      'odds2': odds2,
      'subtitle1': subtitle1,
      'subtitle2': subtitle2,
      'winner': 0,
      'team1score': '',
      'team2score': ''
    });
  }

  Future setGameAuto(int year, int month, int day, String team1, String team2,
      String odds1, String odds2, String subtitle1, String subtitle2) async {
    QuerySnapshot games = await gamesCollection
        .where('gameID', arrayContains: Gamemanager().getDate())
        .get();
    List<QueryDocumentSnapshot> gamesList = games.docs.toList();
    String docID = year.toString() +
        ' ' +
        month.toString() +
        ' ' +
        day.toString() +
        ' G' +
        (gamesList.length + 1).toString();
    return await gamesCollection.doc(docID).set({
      'gameID': docID,
      'team1': team1,
      'team2': team2,
      'odds1': odds1,
      'odds2': odds2,
      'subtitle1': subtitle1,
      'subtitle2': subtitle2,
      'winner': 0,
      'team1score': '',
      'team2score': ''
    });
  }

  Future setGameToday(int game, String team1, String team2, String odds1,
      String odds2, String subtitle1, String subtitle2) async {
    String docID = Gamemanager().getGameID(game);
    return await gamesCollection.doc(docID).set({
      'gameID': docID,
      'team1': team1,
      'team2': team2,
      'odds1': odds1,
      'odds2': odds2,
      'subtitle1': subtitle1,
      'subtitle2': subtitle2,
      'winner': 0,
      'team1score': '',
      'team2score': ''
    });
  }

  Future setGameWinner(
      String gameID, String team1score, String team2score, int winner) async {
    return await gamesCollection.doc(gameID).update(
        {'team1score': team1score, 'team2score': team2score, 'winner': winner});
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
        gameID: doc.data()['gameID'],
        team1: doc.data()['team1'],
        team2: doc.data()['team2'],
        odds1: doc.data()['odds1'],
        odds2: doc.data()['odds2'],
        subtitle1: doc.data()['subtitle1'],
        subtitle2: doc.data()['subtitle2'],
        team1score: doc.data()['team1score'],
        team2score: doc.data()['team2score'],
        winner: doc.data()['winner']);
  }
}
