import 'package:firebase_auth/firebase_auth.dart';
import 'package:gang_brew_crew/models/custom_user.dart';
import 'package:gang_brew_crew/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create Custom User object on User
  CustomUser _customUserFromUser(User user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<CustomUser> get user {
    return _auth.authStateChanges().map(_customUserFromUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      CustomUser user = _customUserFromUser(result.user);
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email/password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _customUserFromUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // register with email/password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      // create a new doc for this user
      await DatabaseService(uid: user.uid).updateUserData("0", "New ganger", 100);

      return _customUserFromUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}