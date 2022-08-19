import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
var topicLink =
    "https://script.google.com/macros/s/AKfycbxlb2z-kyu8ZyuwpXA0Xx8ph6TJPe91UGQdU-mETwBr4XPZYxO1Kgi2ovSjF1Ev18fb7A/exec";

var questionList = [];
var topicList = [];
var ques = [];
int ans = -1;

getTopic() async {
  var r = await http.get(Uri.parse(topicLink));
  if( r.statusCode == 200 ){
    topicList = jsonDecode(r.body);
    return topicList;
  }
}

getQuiz(link) async {
  var res = await http.get(Uri.parse(link));
  if (res.statusCode == 200) {
    questionList = [];
    questionList = jsonDecode(res.body);
    return questionList;
  }
}

int giveRandomQuestion() {
  final random = Random();
  var max = questionList.length;
  int randomNumber = random.nextInt(max);
  return randomNumber;
}