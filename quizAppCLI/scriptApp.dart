import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class ScriptApp {
  static var link = 'https://script.google.com/macros/s/AKfycbwtE-23Iqc9BXzH8kNG62XY6-EBsjL3j_Qisqd93m7xpjZbHlA4_Q8etou8zRehSZJNtA/exec';

  static bool loadingTopic = false;
  static var topic;
  static int ans = -1;

  static Future getTopic() async {
    var response = await http.get(Uri.parse(link));
    if( response.statusCode == 200 ){
      topic = jsonDecode(response.body.toString());
      loadingTopic = true;
    }
  }

  static bool loadingQuestions = true;
  static List< List<dynamic> > questionsList = [];

  static Future getQuestions( sheetLink ) async {
    loadingQuestions = true;
    print('Loading Questions');
    var raw = await http.get(Uri.parse(sheetLink));
    if( raw.statusCode == 200 ){
      var questions = jsonDecode(raw.body.toString());
      questionsList = [];
      questions.forEach((element) {

        List<dynamic> components = [];

        components.add(element['question']);
        components.add(element['optionA']);
        components.add(element['optionB']);
        components.add(element['optionC']);
        components.add(element['optionD']);
        components.add(element['answer']);
        
        questionsList.add(components);
      });
      loadingQuestions = false;
      print('Question Loaded');
    }
  }

  static Future giveRandomQuestion() async {
    if( questionsList == null ) {
      print("All question Attempted!!");
      return;
    }

    final random = new Random();
    int min = 0;
    int max = await questionsList.length - 1;
    int randomNumber = min + random.nextInt( max - min );

    print("Total Time : 45 Seconds...\n");
    print( "Q. ${questionsList[randomNumber][0]}" ); 
    print( "1. ${questionsList[randomNumber][1]}" ); 
    print( "2. ${questionsList[randomNumber][2]}" ); 
    print( "3. ${questionsList[randomNumber][3]}" ); 
    print( "4. ${questionsList[randomNumber][4]}" ); 
    print( "5. Skip to Next Question" );
    print( "6. Choose a different topic" );
    print( "7. Exit the quiz" );

    ans = int.parse("${questionsList[randomNumber][5]}");

    questionsList.removeAt(randomNumber);
  }

}