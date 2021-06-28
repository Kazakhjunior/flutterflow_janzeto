import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class JanzettoFirebaseUser {
  JanzettoFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

JanzettoFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<JanzettoFirebaseUser> janzettoFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<JanzettoFirebaseUser>(
            (user) => currentUser = JanzettoFirebaseUser(user));
