import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

void main() {
  runApp(MyApp());
}

FirebaseAuth auth = FirebaseAuth.instance;
String email;
String password;
bool showSpinner = false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TheApp(),
    );
  }
}

class TheApp extends StatefulWidget {
  @override
  _TheAppState createState() => _TheAppState();
}

class _TheAppState extends State<TheApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            // size: 25,
                            size: 25,
                          ),
                          Expanded(
                            child: SvgPicture.asset(
                              "images/signin.svg",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(35, 45, 35, 25),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffF2F2F2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                      child: Column(
                        children: [
                          //1) sign in title
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: Center(
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Raleway"),
                              ),
                            ),
                          ),
                          //2) Email Address, Password textfield
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //2)email address text field
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(6, 0, 0, 4),
                                      child: Text(
                                        "Email Address",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: TextField(
                                          onChanged: (value) {
                                            email = value;
                                          },
                                          decoration: InputDecoration(
                                            // fillColor: Colors.white,

                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(6, 0, 0, 4),
                                      child: Text(
                                        "Password",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: TextField(
                                          onChanged: (value) {
                                            password = value;
                                          },
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            // fillColor: Colors.white,
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          //3) Forgot_pa, signin button, signup link
                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Forgot Password?",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: "Raleway"),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            showSpinner = true;
                                          });
                                          try {
                                            final user = await auth
                                                .signInWithEmailAndPassword(
                                                    email: email,
                                                    password: password);
                                            if (user != null) {
                                              // Navigator.pushNamed(context, ChatScreen.id);
                                              print(
                                                  "You are successfully logged in");
                                            }

                                            setState(() {
                                              showSpinner = false;
                                            });
                                          } catch (e) {
                                            print(e);
                                            print("Could not log you in");
                                            setState(() {
                                              showSpinner = false;
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: 55,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xff9D4BFF),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Sign in",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: "Raleway"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "I'm a new user. ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Raleway"),
                                      ),
                                      GestureDetector(
                                        child: Text(
                                          "Sign Up",
                                          style: TextStyle(
                                              color: Color(0xff9D4BFF),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Raleway"),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
