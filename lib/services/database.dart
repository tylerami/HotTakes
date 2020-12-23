import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future updateUserData(String username, String team1, String team2, int streak,
      int picksRemaining) async {
    return await userDataCollection.doc(uid).set({
      'username': username,
      'team1': team1,
      'team2': team2,
      'streak': streak,
      'picksRemaining': picksRemaining
    });
  }
}
