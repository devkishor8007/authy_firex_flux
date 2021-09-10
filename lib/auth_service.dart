import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn gs = GoogleSignIn();

  static final User? users = _auth.currentUser;

  static Future<User?> loginwithEmail(
      {required String email, required String password}) async {
    try {
      final res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return res.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<User?> signupwithEmail(
      {required String email, required String password}) async {
    try {
      final res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return res.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static logout() {
    gs.signOut();
    return _auth.signOut();
  }

  static Future<bool> resetpassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  static changepassword({required String newPassword}) async {
    return await users!.updatePassword(newPassword);
  }

  static verifyEmail() async {
    if (users != null && !users!.emailVerified) {
      return await users!.sendEmailVerification();
    }
  }

  static Future<User?> signInwithGoogle() async {
    try {
      final googleUser = await gs.signIn();
      final googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      final res = await _auth.signInWithCredential(credential);
      return res.user;
    } catch (e) {}
  }
}
