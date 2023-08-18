import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:plantmonitoringsystem/utils/utils.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  // FOR EVERY FUNCTION HERE
  // POP THE ROUTE USING: Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

  // GET USER DATA
  // using null check operator since this method should be called only
  // when the user is logged in
  User get user => _auth.currentUser!;

  // STATE PERSISTENCE STREAM
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
  // OTHER WAYS (depends on use case):
  // Stream get authState => FirebaseAuth.instance.userChanges();
  // Stream get authState => FirebaseAuth.instance.idTokenChanges();
  // KNOW MORE ABOUT THEM HERE: https://firebase.flutter.dev/docs/auth/start#auth-state

  // EMAIL SIGN UP
  Future<bool> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // await sendEmailVerification(context);

      return true;
    } on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        showSnackbar(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnackbar(context, 'The account already exists for that email.');
      }
      showSnackbar(
          context, e.message!); // Displaying the usual firebase error message
      return false;
    }
  }

  // EMAIL LOGIN
  Future<bool> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // if (!user.emailVerified) {
      //   await sendEmailVerification(context);
      // }

      return true;
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message!); // Displaying the error message
      return false;
    }
  }

  // FORGOT PASSWORD
  Future<bool> forgotPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
      // ignore: use_build_context_synchronously
      showSnackbar(context,
          'An email has been sent to $email with instructions on how to reset your password.');
      return true;
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message!); // Displaying the error message
      return false;
    }
  }

  // EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackbar(context, 'Email verification sent, please check you inbox.');
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message!); // Display error message
    }
  }

  // SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message!); // Displaying the error message
    }
  }

  // DELETE ACCOUNT
  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message!); // Displaying the error message
      // if an error of requires-recent-login is thrown, make sure to log
      // in user again and then delete account.
    }
  }
}
