import 'package:flutter/material.dart';
import 'package:quizzd/api_services.dart';
import 'package:quizzd/const/colors.dart';
import 'package:quizzd/const/text_style.dart';
import 'package:quizzd/main.dart';
import 'package:quizzd/quiz_screen.dart';

var topiklink = '';

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  late Future tList;

  @override
  void initState() {
    super.initState();
    tList = getTopic();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: headingText(
            text: "Quizzd", color: Colors.white, size: screenHeight! * 0.04),
        backgroundColor: blue,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(
              screenWidth! * 0.05,
              screenHeight! * 0.02,
              screenWidth! * 0.05,
              screenHeight! * 0.02),
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [blue, darkBlue]),
          ),
          child: FutureBuilder(
            future: tList,
            builder: (BuildContext context, AsyncSnapshot ss) {
              if (ss.hasData) {
                var tpcList = ss.data;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: ss.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        topiklink = tpcList[index]['API Link'];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QuizScreen()));
                      },
                      child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            top: screenHeight! * 0.08,
                            // bottom: screenHeight! * 0.05,
                          ),
                          padding:
                              EdgeInsets.only(top: screenHeight! * 0.05),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: lightgrey,
                              style: BorderStyle.solid,
                            ),
                            borderRadius:
                                BorderRadius.circular(screenWidth! * 0.05),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: screenWidth! * 0.8,
                                height: screenHeight! * 0.4,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: lightgrey,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(
                                        screenWidth! * 0.05),
                                    boxShadow: [
                                      BoxShadow(
                                          color: lightgrey,
                                          blurRadius: screenWidth! * 0.03,
                                          blurStyle: BlurStyle.normal,
                                          offset: Offset.zero),
                                    ]),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      screenWidth! * 0.05),
                                  child: Image.asset(
                                    "assets/${tpcList[index]['img']}.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight! * 0.02,
                              ),
                              Text(
                                "${tpcList[index]['topic']}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: darkBlue,
                                    fontSize: screenHeight! * 0.05,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: screenHeight! * 0.03,
                              ),
                            ],
                          )),
                    );
                  },
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                    normalText(
                        text: "Loading Topics...",
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
