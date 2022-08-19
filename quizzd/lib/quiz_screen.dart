import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quizzd/api_services.dart';
import 'package:quizzd/const/colors.dart';
import 'package:quizzd/const/images.dart';
import 'package:quizzd/last_screen.dart';
import 'package:quizzd/main.dart';
import 'package:quizzd/const/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:quizzd/topics_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int seconds = 60;
  Timer? timer;
  late Future quiz;
  int points = 0;
  var pnts = ["", "", "", "", ""];
  var isLoaded = false;
  var list = [];
  String question = '';
  String optionA = '';
  String optionB = '';
  String optionC = '';
  String optionD = '';
  var options = [];
  int correctAnswer = -1;
  int randNum = -1;
  var optionColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  resetColors() {
    optionColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

  resetPnts() {
    pnts = ["", "", "", "", ""];
  }

  @override
  void initState() {
    super.initState();
    quiz = getQuiz(topiklink);
    startTimer();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  startTimer() async {
    timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => {
              setState(
                () {
                  if (seconds > 0) {
                    seconds--;
                  } else if (list.length > 1) {
                    optionColor[correctAnswer - 1] = Colors.green;
                    Future.delayed(const Duration(seconds: 1), () {
                      list.removeAt(randNum);
                      isLoaded = false;
                      resetColors();
                      resetPnts();
                      timer.cancel();
                      seconds = 60;
                      startTimer();
                    });
                  } else {
                    timer.cancel();
                    finalPoints = points;
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LastScreen()));
                    });
                  }
                },
              )
            });
  }

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
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [blue, darkBlue]),
          ),
          child: FutureBuilder(
            future: quiz,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                int len = snapshot.data.length;
                list = snapshot.data;
                if (isLoaded == false) {
                  randNum = giveRandomQuestion();
                  question = list[randNum]['question'];
                  correctAnswer = list[randNum]['answer'];
                  options = [];
                  options.add(list[randNum]['optionA']);
                  options.add(list[randNum]['optionB']);
                  options.add(list[randNum]['optionC']);
                  options.add(list[randNum]['optionD']);
                  isLoaded = true;
                }
                return Column(
                  children: [
                    SizedBox(
                      height: screenHeight! * 0.005,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: lightgrey,
                                width: screenWidth! * 0.008,
                              )),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                CupertinoIcons.xmark,
                                color: Colors.white,
                                size: screenHeight! * 0.03,
                              )),
                        ),
                        Stack(alignment: Alignment.center, children: [
                          normalText(
                              text: "$seconds",
                              color: Colors.white,
                              size: screenHeight! * 0.03),
                          SizedBox(
                            height: screenWidth! * 0.15,
                            width: screenWidth! * 0.15,
                            child: CircularProgressIndicator(
                              value: seconds / 60,
                              valueColor:
                                  const AlwaysStoppedAnimation(Colors.white),
                            ),
                          ),
                        ]),
                        Container(
                          height: screenHeight! * 0.058,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(screenWidth! * 0.02),
                            border: Border.all(
                                width: screenWidth! * 0.004,
                                color: lightgrey),
                          ),
                          child: TextButton.icon(
                              onPressed: null,
                              icon: Icon(
                                CupertinoIcons.heart_fill,
                                color: Colors.white,
                                size: screenHeight! * 0.02,
                              ),
                              label: normalText(
                                  text: "Like",
                                  color: Colors.white,
                                  size: screenHeight! * 0.018)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight! * 0.05,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          ideas,
                          height: screenHeight! * 0.05,
                        ),
                        normalText(
                            text: "    Question Number $len",
                            color: lightgrey,
                            size: screenHeight! * 0.02),
                      ],
                    ),
                    SizedBox(height: screenHeight! * 0.05),
                    normalText(
                        color: Colors.white,
                        size: screenHeight! * 0.03,
                        text: question),
                    SizedBox(height: screenHeight! * 0.05),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (index + 1 == correctAnswer) {
                                    optionColor[index] = Colors.green;
                                    points += 10;
                                    pnts[index] =
                                        "                          +10";
                                  } else {
                                    optionColor[index] = Colors.red.shade400;
                                    points -= 2;
                                    pnts[index] =
                                        "                          -2";
                                  }
                                });
                                optionColor[correctAnswer - 1] = Colors.green;
                                if (list.length > 1) {
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    list.removeAt(randNum);
                                    isLoaded = false;
                                    resetColors();
                                    resetPnts();
                                    timer!.cancel();
                                    seconds = 60;
                                    startTimer();
                                  });
                                } else {
                                  timer!.cancel();
                                  finalPoints = points;
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LastScreen()));
                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(screenHeight! * 0.015),
                                margin: EdgeInsets.only(
                                    bottom: screenHeight! * 0.01),
                                width: screenWidth! * 0.90,
                                decoration: BoxDecoration(
                                    color: optionColor[index],
                                    borderRadius: BorderRadius.circular(
                                        screenHeight! * 0.01)),
                                child: headingText(
                                    text: options[index].toString() +
                                        pnts[index].toString(),
                                    color: darkBlue,
                                    size: screenHeight! * 0.03),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                    normalText(
                        text: "Loading Questions...",
                        color: lightgrey,
                        size: screenHeight! * 0.02)
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
