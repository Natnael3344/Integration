import 'package:flutter/material.dart';
import 'Auth.dart';
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: 100),
      child: Center(
        child: Column(
          children: [
            CircleAvatar(
                backgroundColor: Colors.amber,
                radius: 107,
                child: CircleAvatar(
                  backgroundImage:
                      login ? NetworkImage(imageUrl) : NetworkImage(fImage),
                  foregroundColor: Colors.amber,
                  radius: 100,
                )),
            Padding(
              padding: EdgeInsets.only(
                top: 1,
              ),
              child: Text(
                login ? name.toUpperCase() : fName,
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Colors.amber),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                login ? email : fEmail,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    color: Colors.amber),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(250, 249, 184, 1),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
              onPressed: () {
                login
                    ? signOutGoogle().then((value) => Navigator.pop(context))
                    : signOutFacebook().then((value) => Navigator.pop(context));
              },
              child: Text(
                'Sign Out',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
