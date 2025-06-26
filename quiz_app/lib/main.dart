import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Map<String, Object>> _questions = [
    {
      'question': 'What is the capital of France?',
      'answers': ['Berlin', 'London', 'Paris', 'Madrid'],
      'correct': 'Paris',
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'answers': ['Earth', 'Mars', 'Jupiter', 'Saturn'],
      'correct': 'Mars',
    },
    {
      'question': 'Who wrote "Macbeth"?',
      'answers': ['Shakespeare', 'Dickens', 'Tolstoy', 'Hemingway'],
      'correct': 'Shakespeare',
    },
  ];

  int _questionIndex = 0;
  int _score = 0;

  void _answerQuestion(String selectedAnswer) {
    String correctAnswer = _questions[_questionIndex]['correct'] as String;

    if (selectedAnswer == correctAnswer) {
      setState(() {
        _score++;
      });
    }

    setState(() {
      _questionIndex++;
    });
  }

  void _restartQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasMoreQuestions = _questionIndex < _questions.length;

    return Scaffold(
      appBar: AppBar(title: Text('Quiz App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: hasMoreQuestions
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _questions[_questionIndex]['question'] as String,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  ...(_questions[_questionIndex]['answers'] as List<String>)
                      .map((answer) => ElevatedButton(
                            onPressed: () => _answerQuestion(answer),
                            child: Text(answer),
                          )),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Quiz Completed!\nYour Score: $_score / ${_questions.length}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _restartQuiz,
                    child: Text('Restart Quiz'),
                  )
                ],
              ),
      ),
    );
  }
}
