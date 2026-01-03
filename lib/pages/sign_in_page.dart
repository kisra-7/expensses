import 'package:expenses_tracker/pages/home_page.dart';
import 'package:expenses_tracker/pages/sign_up_page.dart';
import 'package:expenses_tracker/providers/auth_provider.dart';
import 'package:expenses_tracker/providers/google_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_button/sign_in_button.dart';

// ignore: must_be_immutable
class SignInPage extends ConsumerWidget {
  SignInPage({super.key});
  TextEditingController emailCon = TextEditingController();

  TextEditingController passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailCon,
              decoration: InputDecoration(
                hint: Text('Email'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            TextField(
              obscureText: true,
              controller: passwordCon,

              decoration: InputDecoration(
                hint: Text('Password'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            InkWell(
              onTap: () async {
                await ref
                    .read(authProvider.notifier)
                    .signInUserWithEmailAndPassword(
                      context: context,
                      email: emailCon.text.trim(),
                      paswword: passwordCon.text.trim(),
                    );
                if (FirebaseAuth.instance.currentUser != null) {
                  Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePage();
                      },
                    ),
                  );
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.195,
                ),
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.tealAccent,
                ),
                child: Center(
                  child: Text('Sign in', style: TextStyle(color: Colors.black)),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(100),
              child: SignInButton(
                Buttons.google,
                onPressed: () async {
                  await ref.watch(googleAuth.notifier).signInWithGoogle();
                  if (FirebaseAuth.instance.currentUser != null) {
                    Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.07),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dont have an account? '),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpPage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
