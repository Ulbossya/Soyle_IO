import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:math';

void main() {
  runApp(AnotherPage());
}

class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soyle IO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SpeechScreen(),
    );
  }
}

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  double _confidence = 0.0;

  final List<String> _questions = [
    'What is your favorite color?',
    'What do you like to do in your free time?',
    'What is your favorite food?',
    'Where would you like to travel?',
    'What is your dream job?',
  ];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _generateRandomQuestion();
  }

  void _generateRandomQuestion() {
    final Random random = Random();
    final int randomNumber = random.nextInt(_questions.length);
    setState(() {
      _text = _questions[randomNumber];
    });
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() {
          _isListening = true;
          _text = ''; // Clear the text when listening starts
        });
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вопросы'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 5,
                color: Color(0xFFBE8396), // Цвет карточки
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SizedBox(
                  width: 313,
                  height: 306,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _text,
                        style: TextStyle(
                          fontFamily: 'Benzin', // Шрифт Benzin
                          fontSize: 24,
                          color: Colors.white, // Цвет текста
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _generateRandomQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFBE8396), // Цвет кнопки
                ),
                child: Text(
                  'Следующий вопрос',
                  style: TextStyle(
                    fontFamily: 'Benzin', // Шрифт Benzin
                    fontSize: 24,
                    color: Colors.white, // Цвет текста
                  ),
                ),
              ),
              SizedBox(height: 20),
              IconButton(
                icon: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  color: Color(0xFF809BFA), // Цвет микрофона
                ),
                onPressed: _listen,
                iconSize: 48.0,
              ),
              SizedBox(height: 20),
              Text(
                'Уверенность: ${(_confidence * 100).toStringAsFixed(1)}%',
                style: TextStyle(
                  fontFamily: 'Benzin', // Шрифт Benzin
                  fontSize: 24,
                  color: Color(0xFF809BFA),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
