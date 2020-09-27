import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  //signup method :3
  //start signup method!
  Future<AuthResult> signUp(String email, String password) async {
    final authresult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return authresult;
  }

  //end signup method!
  //
  //signin method :3
  //
  //start Signin method ! :3
  Future<AuthResult> signIn(String email, String password) async {
    final authresult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return authresult;
  }

  //end Signin method! :3
  //
  //Signout method :3
  //
  //start Signout method ! :3
  Future<void> signOutt() async {
    await _auth.signOut();
  }
}
