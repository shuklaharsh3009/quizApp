import 'dart:async';
import 'dart:io';
import 'scriptApp.dart';

int topicNumber = -1, choice = -1;
int timerCount = 45, scoreCount = 0;
bool timeOut = false, topicFound = false, qLoaded = false;
List< List<dynamic> > list = [];

//Shows the topics for the quiz...
Future start() async {
  topicFound = false;
  print("#############################");
  print("Select your topic -> ");
  int l = ScriptApp.topic.length;
  for(int i = 0; i < l; i++){
    print("${i+1}. ${ScriptApp.topic[i]['topic']}");
  }
  print("#############################");
  topicNumber = int.parse(stdin.readLineSync()!);
  print("#############################\n");
  topicFound = true;
}

Future main() async {
  
  await ScriptApp.getTopic();
  //Wait to Load Topics
  print("Loading Topics...");
  Timer.periodic(Duration(milliseconds: 500), (timer){
    if( ScriptApp.loadingTopic ){
      timer.cancel();
      start();
    }
  });

  //Waiting for the topic to be selected...
  Timer.periodic(Duration(milliseconds: 250), (timer) async {
    if( topicFound == true ){
      timer.cancel();
      await topicSelector();
    }
  });

  //sending questions...
  Timer.periodic(Duration(milliseconds: 250), (timer) async { 
    if( qLoaded ){
      timer.cancel();
      await questionDisplay();
    }
  });

}

// to display random questions and control the further actions
Future questionDisplay() async {
    while( choice != -5 ){
      print("\nScore -> $scoreCount");
      await ScriptApp.giveRandomQuestion();
      choice = int.parse(stdin.readLineSync()!);
      if( choice == ScriptApp.ans ){
        print("Answer is Correct!!! :)");
        scoreCount += 4;
        print('Score -> $scoreCount');
        continue;
      } else if( choice == 5 ){
        continue;
      } else if( choice == 6 ){
        start();
        await topicSelector();
        await questionDisplay();
        break;
      } else if( choice == 7 ){
        print("\nI hope you had fun, See you Soon!!!!\n");
        exit(0); 
      } else if( choice > 0 && choice < 5) {
        print("Sorry, your answer is wrong :(\nThe Correct Option is -> ${ScriptApp.ans}");
        scoreCount -= 1;
        print('Score -> $scoreCount');
      }
    }
  }

//Selecting the questions and sending the API link to get the questions
Future topicSelector() async {
  
  await ScriptApp.getQuestions( ScriptApp.topic[topicNumber-1]['API Link']);

  Timer.periodic(Duration(milliseconds: 250), (timer) { 
    if( ScriptApp.loadingQuestions == false ){
      qLoaded = true;
    }
  });
  
}