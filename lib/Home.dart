import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Auth.dart';
import 'LogIn.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading1 == false
          ? Center(
              child: SpinKitChasingDots(
                color: Colors.amber,
                size: 60,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 100, bottom: 50),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Color.fromARGB(250, 249, 184, 1),
                          fontWeight: FontWeight.w900,
                          fontSize: 30),
                    ),
                  ),
                  Text(
                    'Login with',
                    style: TextStyle(
                        color: Colors.black38, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 120,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color.fromARGB(250, 249, 184, 1),
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft:
                                                Radius.elliptical(20, 20))))),
                            onPressed: () {
                              signInWithFacebook().then((result) {
                                if (result != null) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Login();
                                      },
                                    ),
                                  );
                                }
                              }).whenComplete(() => setState(() {
                                    loading1 = true;
                                  }));
                              setState(() {
                                loading1 = false;
                              });
                            },
                            child: Icon(
                              FontAwesomeIcons.facebook,
                              size: 40,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color.fromARGB(250, 249, 184, 1),
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight:
                                                Radius.elliptical(20, 20))))),
                            onPressed: () {
                              signInWithGoogle().then((result) {
                                if (result != null) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Login();
                                      },
                                    ),
                                  );
                                }
                              });
                            },
                            child: Icon(
                              FontAwesomeIcons.googlePlus,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    'or Login With Email',
                    style: TextStyle(
                        color: Colors.black38, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 30, right: 30, top: 20, bottom: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: Color.fromARGB(250, 249, 184, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.w900),
                        labelText: 'Email',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(250, 249, 184, 1)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: Color.fromARGB(250, 249, 184, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.w900),
                        labelText: 'Password',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(250, 249, 184, 1)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      obscureText: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 30, right: 30, top: 100, bottom: 20),
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(250, 249, 184, 1),
                            ),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        onPressed: () {},
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                            color: Colors.black38, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' Register',
                        style: TextStyle(
                            color: Color.fromARGB(250, 249, 184, 1),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SpinKitChasingDots(
                    color: Colors.amber,
                    size: 50,
                    duration: Duration(seconds: 5),
                  ),
                ],
              ),
            ),
    );
  }
}
