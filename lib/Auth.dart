import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final facebookLogin = FacebookLogin();
final FirebaseAuth auth = FirebaseAuth.instance;
String fName;
String fEmail;
String fImage;
var profile;
bool login = true;

Future<String> signInWithFacebook() async {
  User currentUser;
  try {
    login = false;
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final FacebookLoginResult facebookLoginResult =
        await facebookLogin.logIn(['email', 'public_profile']);
    if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
      var url = Uri.parse(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${facebookLoginResult.accessToken}');
      final graphResponse = await http.get(url);
      profile = jsonDecode(graphResponse.body);
      final AuthCredential credential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken.token);
      final UserCredential authResult =
          await auth.signInWithCredential(credential);
      final User user = authResult.user;
      fName = user.displayName;
      fEmail = user.uid;
      fImage = user.photoURL;
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      currentUser = auth.currentUser;
      assert(user.uid == currentUser.uid);
      return '$user';
    }
  } catch (e) {
    print(e);
    return "$currentUser";
  }
  return 'not sign in';
}

Future<void> signOutFacebook() async {
  await facebookLogin.logOut();
  FirebaseAuth.instance.signOut();
  login = true;
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String name;
String email;
String imageUrl;

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    return '$user';
  }

  return 'not sign in';
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
}
