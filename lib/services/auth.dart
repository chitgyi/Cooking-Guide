import 'package:cooking_guide/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User userFromFirebase(FirebaseUser user) {
    if (user != null) {
      if (user.providerData[1].providerId.toString() == "facebook.com") {
        return User(user.uid);
      } else {
        if (user.isEmailVerified) {
          return User(user.uid);
        } else {
          return null;
        }
      }
    }
    return null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(userFromFirebase);
  }

  Future<User> signInWithEmail({String email, String password}) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(result.user.providerId);
      return userFromFirebase(result.user);
    } catch (e) {
      return null;
    }
  }

  Future signInWithFb() async {
    await FacebookLogin().logIn(['email', 'public_profile']).then((onValue) {
      AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: onValue.accessToken.token);
      FirebaseAuth.instance.signInWithCredential(credential).then((onValue) {
        userFromFirebase(onValue.user);
      });
    }).catchError((onError) {});
  }

  Future signInAno() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      return userFromFirebase(result.user);
    } catch (e) {
      return null;
    }
  }

  Future signOut() async {
    try {
      var fb = FacebookLogin();
      var fbLogged = await fb.isLoggedIn;

      if (fbLogged) {
        await fb.logOut();
      }

      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  Future<bool> signUpWithEmail(
      {String name, String email, String password}) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = name;
      await authResult.user.sendEmailVerification();
      authResult.user.updateProfile(userUpdateInfo);
      return true;
    } catch (e) {
      return false;
    }
  }
}
