//welcome screen with features to login register and google sign in

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/chat_list.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/selection.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_list.dart';

final _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
bool isGoogle = false;

Future signInWithGoogle() async {
  //Google sign in implementation
  try {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    loggedInUser = await _auth.currentUser();
    assert(user.uid == loggedInUser.uid);
    isGoogle = true;
  } catch (e) {
    print(e);
  }
}

void signOutGoogle() async {
  //google sign out
  await googleSignIn.signOut();

  print("User Sign Out");
}

class WelcomeScreen extends StatefulWidget {
  static const String id = '/welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  GoogleSignInAccount _currentUser;
  String _contactText;

  @override
  void initState() {
    super.initState();
    //logo animation setting
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(
      () {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _signInButton() {
      //Google sign in button
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: OutlineButton(
          splashColor: Colors.grey,
          onPressed: () async {
            var status = await signInWithGoogle();
            signInWithGoogle().whenComplete(() {
              Navigator.pushNamed(context, ChatList.id); // Successful sign in
            });
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          highlightElevation: 0,
          borderSide: BorderSide(color: Colors.grey),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                    image: AssetImage("images/google_logo.png"), height: 35.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/training_icon.png'),
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  //logo animation
                  speed: Duration(milliseconds: 500),
                  text: [' Scholastic'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RoundedButton(
                  //login button
                  onPress: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  color: Colors.lightBlueAccent,
                  text: 'Log In',
                ),
                RoundedButton(
                  //register button
                  color: Colors.blueAccent,
                  text: 'Register',
                  onPress: () {
                    Navigator.pushNamed(context, Selection.id);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: _signInButton(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
