import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:intl/intl.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(SmartVoiceAssistantApp());
}

class SmartVoiceAssistantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VoiceAssistantScreen(),
    );
  }
}

class VoiceAssistantScreen extends StatefulWidget {
  @override
  _VoiceAssistantScreenState createState() => _VoiceAssistantScreenState();
}

class _VoiceAssistantScreenState extends State<VoiceAssistantScreen> {
  stt.SpeechToText _speech = stt.SpeechToText();
  FlutterTts _tts = FlutterTts();
  bool _isListening = false;
  String _transcribedText = "";

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print('Status: $status'),
      onError: (error) => print('Error: $error'),
    );
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(onResult: (result) {
        setState(() {
          _transcribedText = result.recognizedWords;
        });
        _talk("You said: ${result.recognizedWords}");
        _handleCommand(result.recognizedWords);
      });
    } else {
      _talk("Speech recognition is not available.");
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  void _generateTasks() {
    List<String> sentences = _transcribedText.split(RegExp(r'[.,;]|\band\b', caseSensitive: false));
    List<String> tasks = [];

    for (String sentence in sentences) {
      if (sentence.contains(RegExp(r'\b(meeting|mail|email|call|buy)\b', caseSensitive: false))) {
        tasks.add(sentence.trim());
      }
    }

    setState(() {
      _transcribedText += "\n\nExtracted Tasks:\n" + (tasks.isNotEmpty ? tasks.join("\n") : "No tasks detected.");
    });

    _talk(tasks.isNotEmpty ? "Tasks extracted successfully." : "No tasks detected.");
  }

  void _addToCalendar() {
    DateTime now = DateTime.now();

    setState(() {
      _transcribedText += "\n\nMeeting scheduled on: " +
          DateFormat('MMMM d, yyyy h:mm a').format(now);
    });

    _talk("Meeting scheduled on ${DateFormat('MMMM d, yyyy h:mm a').format(now)}");
  }

  void _talk(String text) async {
    await _tts.speak(text);
  }

  String _todayDate() {
    DateTime now = DateTime.now();
    String weekNow = DateFormat('EEEE').format(now);
    String monthNow = DateFormat('MMMM').format(now);
    int dayNow = now.day;

    List<String> ordinals = [
      "1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th",
      "11th", "12th", "13th", "14th", "15th", "16th", "17th", "18th", "19th", "20th",
      "21st", "22nd", "23rd", "24th", "25th", "26th", "27th", "28th", "29th", "30th", "31st"
    ];

    return "Today is $weekNow, $monthNow the ${ordinals[dayNow - 1]}.";
  }

  String _sayHello(String text) {
    List<String> greet = ["hi", "hey", "hola", "greetings", "wassup", "hello"];
    List<String> response = ["howdy", "whats good", "hello", "hey there"];

    for (String word in text.split(" ")) {
      if (greet.contains(word.toLowerCase())) {
        return "${response[Random().nextInt(response.length)]}.";
      }
    }
    return "";
  }

  void _handleCommand(String command) {
    if (command.toLowerCase().contains("date")) {
      String dateMessage = _todayDate();
      _talk(dateMessage);
      setState(() {
        _transcribedText += "\n$dateMessage";
      });
    } else {
      String greeting = _sayHello(command);
      if (greeting.isNotEmpty) {
        _talk(greeting);
        setState(() {
          _transcribedText += "\n$greeting";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Smart Voice Assistant')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _transcribedText,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _isListening ? _stopListening : _startListening,
                  child: Icon(_isListening ? Icons.mic_off : Icons.mic),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _generateTasks,
                  child: Text('Extract Tasks'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _addToCalendar,
                  child: Text('Add to Calendar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
