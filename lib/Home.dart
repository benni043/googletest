import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                signInWithGoogle();
              },
              child: Text("Google - SignIn"),
            ),
            TextButton(
              onPressed: () {
                signOutWithGoogle();
              },
              child: Text("Google - SignOut"),
            ),
          ],
        )
      ),
    );
  }

  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn(clientId: "771830925506-o0dnlaq823vt4fjuci1ofmhr753hsum1.apps.googleusercontent.com").signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(authCredential);

    print(userCredential.user?.email);
    print(userCredential.user?.displayName);
    print(userCredential.user?.phoneNumber);
    print(userCredential.user?.photoURL);
  }

  signOutWithGoogle() async {
    await GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
  }
}
