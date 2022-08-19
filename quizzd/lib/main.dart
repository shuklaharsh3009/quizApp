import 'package:quizzd/const/colors.dart';
import 'package:quizzd/const/images.dart';
import 'package:flutter/material.dart';
import 'package:quizzd/const/text_style.dart';
import 'package:quizzd/topics_screen.dart';

double? screenWidth;
double? screenHeight;
int finalPoints = 0;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const QuizApp(),
      theme: ThemeData(
        fontFamily: 'quick',
      ),
      title: 'Quized',
    );
  }
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(screenWidth! * 0.05,
              screenHeight! * 0.02, screenWidth! * 0.02, screenHeight! * 0.02),
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [blue, darkBlue]),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: screenHeight! * 0.02,
                ),
                Image.asset(
                  balloon2,
                  height: screenHeight! * 0.45,
                ),
                SizedBox(
                  height: screenHeight! * 0.05,
                ),
                normalText(
                    text: "Welcome to our",
                    color: lightgrey,
                    size: screenHeight! * 0.02),
                headingText(
                    text: "Quiz App",
                    color: Colors.white,
                    size: screenHeight! * 0.05),
                SizedBox(
                  height: screenHeight! * 0.02,
                ),
                normalText(
                    text: "Hey, buddy Enjoy the Ride!!!",
                    color: lightgrey,
                    size: screenHeight! * 0.02),
                SizedBox(
                  height: screenHeight! * 0.13,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TopicsScreen()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(screenHeight! * 0.015),
                      width: screenWidth! * 0.90,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(screenHeight! * 0.01)),
                      child: headingText(
                          text: "Continue",
                          color: blue,
                          size: screenHeight! * 0.03),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
