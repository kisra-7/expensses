// ignore_for_file: unused_field, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleAuth = ChangeNotifierProvider<GoogleAuth>((ref) {
  return GoogleAuth();
});

class GoogleAuth extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<void> signInWithGoogle() async {
    await _googleSignIn.initialize();
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final GoogleSignInAccount? googleAccount = await _googleSignIn
        .authenticate();

    if (googleAccount == null) {
      return;
    }
    // ignore: avoid_print
    print(googleAccount.email);
    final GoogleSignInAuthentication googleAuth = googleAccount.authentication;
    final credintials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    await _auth.signInWithCredential(credintials);
  }
}

/*
class GoogleAuth extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<void> signInWithGoole() async {
    await _googleSignIn.initialize();
    final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();
    if (googleUser == null) {
      return;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    await _auth.signInWithCredential(credential);
    // ignore: avoid_print
    print(googleUser.email);
  }
}
*/
