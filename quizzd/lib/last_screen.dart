import 'package:flutter/material.dart';
import 'package:quizzd/const/colors.dart';
import 'package:quizzd/const/images.dart';
import 'package:quizzd/const/text_style.dart';
import 'package:quizzd/topics_screen.dart';
import 'main.dart';

class LastScreen extends StatelessWidget {
  const LastScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(screenWidth! * 0.02,
              screenHeight! * 0.02, screenWidth! * 0.02, screenHeight! * 0.02),
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(bgimg), fit: BoxFit.fill),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Congratulations!!!\nYour Final Score is : $finalPoints",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "quick_bold",
                    fontSize: screenHeight! * 0.05,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight! * 0.26,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TopicsScreen()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(screenHeight! * 0.015),
                    margin: EdgeInsets.only(bottom: screenHeight! * 0.12),
                    width: screenWidth! * 0.90,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(screenHeight! * 0.01)),
                    child: headingText(
                        text: "Start New Quiz",
                        color: darkBlue,
                        size: screenHeight! * 0.04),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
