import 'package:firebase_auth/firebase_auth.dart';
import 'package:hottakes1/models/user.dart';
import 'package:hottakes1/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser _userFromFirebaseUser(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<MyUser> get user {
    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  }

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    if (email == null || email == '') {
      final User user = _auth.currentUser;
      email = user.email;
    }
    await _auth.sendPasswordResetEmail(email: email);
  }

  //register
  Future register(String email, String password, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;
      await DatabaseService(uid: firebaseUser.uid)
          .updateUserData(firebaseUser.uid, username, 'NBA', 'NFL', 0, 1);
      await DatabaseService(uid: firebaseUser.uid)
          .initializeDeliveryInfo(firebaseUser.uid);
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString);
      return null;
    }
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString);
      return null;
    }
  }
}
