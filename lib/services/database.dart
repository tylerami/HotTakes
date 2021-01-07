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
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('userData');
  final CollectionReference userDeliveryCollection =
      FirebaseFirestore.instance.collection('userDelivery');
  final CollectionReference prizeCollection =
      FirebaseFirestore.instance.collection('prizes');

  Future updateUserData(String uid, String username, String league1,
      String league2, int streak, int picksRemaining) async {
    userDataCollection
        .doc(uid)
        .collection('friends')
        .doc('initilize')
        .set({'date': Gamemanager().getDate()});
    return await userDataCollection.doc(uid).set({
      'uid': uid,
      'username': username,
      'league1': league1,
      'league2': league2,
      'streak': streak,
      'picksRemaining': picksRemaining,
      'date': Gamemanager().getDate(),
      'game1': 1,
      'game2': 2,
      'currentPick': 0,
      'notifications': true,
      'streakresetdate': ''
    });
  }

  Future setStreakResetDate(String uid, String date) async {
    return await userDataCollection.doc(uid).update({'streakresetdate': date});
  }

  Future setUserStreak(String uid, int streak) async {
    return await userDataCollection.doc(uid).update({'streak': streak});
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

  Future<bool> isUsernameTaken(String newUsername) async {
    QuerySnapshot query = await userDataCollection
        .where('username', isEqualTo: newUsername)
        .get();
    for (var doc in query.docs.toList()) {
      if (doc.data()['username'] == newUsername) return true;
    }
    return false;
  }

  Future setUsername(String uid, String username) async {
    return await userDataCollection.doc(uid).update({'username': username});
  }

  Future updateUserGames(String uid) async {
    DocumentSnapshot snap = await userDataCollection.doc(uid).get();
    UserData userData = _userDataFromSnapshot(snap);
    if (userData.date.toString() != Gamemanager().getDate()) {
      int game1 = Random().nextInt(2) + 1;
      int game2 = game1;
      while (game1 == game2) {
        game2 = Random().nextInt(2) + 1;
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
        currentPick: doc.data()['currentPick'],
        notifications: doc.data()['notifications'],
        streakResetDate: doc.data()['streakresetdate']);
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
      String subtitle2,
      String logoOverride) async {
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
      'team2score': '',
      'logoOverride': logoOverride
    });
  }

  Future setGameAuto(
      String year,
      String month,
      String day,
      String team1,
      String team2,
      String odds1,
      String odds2,
      String subtitle1,
      String subtitle2,
      String logoOverride) async {
    String docID;
    List<QueryDocumentSnapshot> bigList = [];
    for (int i = 1; i < 6; i++) {
      QuerySnapshot games = await gamesCollection
          .where('gameID',
              isEqualTo: year + ' ' + month + ' ' + day + ' G' + i.toString())
          .get();
      List<QueryDocumentSnapshot> gamesList = games.docs.toList();
      bigList = bigList + gamesList;
    }
    if (bigList != null) {
      docID = year.toString() +
          ' ' +
          month.toString() +
          ' ' +
          day.toString() +
          ' G' +
          (bigList.length + 1).toString();
    } else {
      docID = year.toString() +
          ' ' +
          month.toString() +
          ' ' +
          day.toString() +
          ' G1';
    }
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
      'team2score': '',
      'logoOverride': logoOverride
    });
  }

  Future setGameToday(
      int game,
      String team1,
      String team2,
      String odds1,
      String odds2,
      String subtitle1,
      String subtitle2,
      String logoOverride) async {
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
      'team2score': '',
      'logoOverride': logoOverride
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
        winner: doc.data()['winner'],
        logoOverride: doc.data()['logoOverride']);
  }

  Future setLeague1(String uid, int index) async {
    String league = '';
    switch (index) {
      case 0:
        league = 'NFL';
        break;
      case 1:
        league = 'NBA';
        break;
      case 2:
        league = 'NHL';
        break;
      case 3:
        league = 'MLB';
        break;
      default:
        league = 'NBA';
        break;
    }
    return await userDataCollection.doc(uid).update({'league1': league});
  }

  Future setLeague2(String uid, int index) async {
    String league = '';
    switch (index) {
      case 0:
        league = 'NFL';
        break;
      case 1:
        league = 'NBA';
        break;
      case 2:
        league = 'NHL';
        break;
      case 3:
        league = 'MLB';
        break;
      default:
        league = 'NBA';
        break;
    }
    return await userDataCollection.doc(uid).update({'league2': league});
  }

  Future setNotifications(String uid, bool n) async {
    return await userDataCollection.doc(uid).update({'notifications': n});
  }

  Future initializeDeliveryInfo(String uid) async {
    return await userDeliveryCollection.doc(uid).set({
      'name': '',
      'province': '',
      'city': '',
      'address': '',
      'unitnumber': '',
      'postalcode': ''
    });
  }

  Future updateDeliveryInfo(String uid, String name, String province,
      String city, String address, String unit, String postal) async {
    return await userDeliveryCollection.doc(uid).update({
      'name': name,
      'province': province,
      'city': city,
      'address': address,
      'unitnumber': unit,
      'postalcode': postal
    });
  }

  Stream<DocumentSnapshot> get deliveryInfo {
    return userDeliveryCollection.doc(uid).snapshots();
  }

  Future submitPrizeClaim(String uid, String date, int wins) async {
    return await prizeCollection
        .doc(uid)
        .collection('prizeClaims')
        .doc(date)
        .set({'wins': wins, 'delivered': false});
  }

  Future<List<Game>> getGamesOnDay(String date) async {
    if (date == '') return [];
    List<Game> bigGameList = [];
    for (int i = 1; i < 6; i++) {
      QuerySnapshot snap = await gamesCollection
          .where("gameID", isEqualTo: date + ' G' + i.toString())
          .get();
      List<Game> gameList = snap.docs.map(_gameFromSnapshot).toList();
      bigGameList = bigGameList + gameList;
    }
    return bigGameList;
  }

  Future<List<Game>> showUnfinishedGames() async {
    QuerySnapshot snap =
        await gamesCollection.where('winner', isEqualTo: 0).get();
    return snap.docs.map(_gameFromSnapshot).toList();
  }

  Future<String> _uidFromUsername(String username) async {
    QuerySnapshot snap =
        await userDataCollection.where('username', isEqualTo: username).get();
    List<QueryDocumentSnapshot> list = snap.docs.toList();
    if (list.length != 0) {
      QueryDocumentSnapshot doc = list[0];
      return doc.data()['uid'];
    } else
      return '';
  }

  Future addFriend(String userUid, String friendUsername) async {
    String friendUid = await _uidFromUsername(friendUsername);
    userDataCollection
        .doc(userUid)
        .collection('friends')
        .doc(friendUid)
        .set({'uid': friendUid, 'username': friendUsername});
  }

  Future removeFriend(String userUid, String friendUsername) async {
    String friendUid = await _uidFromUsername(friendUsername);
    userDataCollection
        .doc(userUid)
        .collection('friends')
        .doc(friendUid)
        .delete();
  }

  Future<Pick> pickFromUsername(String username) async {
    if (await isUsernameTaken(username)) {
      QuerySnapshot snap = await userDataCollection
          .doc(await _uidFromUsername(username))
          .collection('picks')
          .get();
      List<Pick> list = _pickSnapshotsToList(snap);
      return list[list.length - 1];
    } else
      return null;
  }

  Stream<List<String>> get friends {
    return userDataCollection
        .doc(uid)
        .collection('friends')
        .where('username', isNotEqualTo: '')
        .snapshots()
        .map<List<String>>(_usernameFromSnapshot);
  }

  List<String> _usernameFromSnapshot(QuerySnapshot snap) {
    return snap.docs.map<String>((doc) {
      return doc.data()['username'];
    }).toList();
  }

  Future<String> streakFromUsername(String username) async {
    String friendUid = await _uidFromUsername(username);
    if (friendUid != '') {
      DocumentSnapshot snap = await userDataCollection.doc(friendUid).get();
      return snap.data()['streak'].toString();
    } else
      return '';
  }
}
