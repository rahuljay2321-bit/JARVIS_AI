import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const JarvisApp());
}

class JarvisApp extends StatelessWidget {
  const JarvisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JARVIS AI',
      theme: ThemeData.dark(),
      home: const JarvisHome(),
    );
  }
}

class JarvisHome extends StatefulWidget {
  const JarvisHome({super.key});

  @override
  State<JarvisHome> createState() => _JarvisHomeState();
}

class _JarvisHomeState extends State<JarvisHome>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  final SpeechToText speech = SpeechToText();
  final FlutterTts tts = FlutterTts();

  bool listening = false;
  bool available = false;

  String message = 'I am always ready to help you.';
  String recognizedText = '';

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    initializeVoice();
  }

  Future<void> initializeVoice() async {
    available = await speech.initialize();

    await tts.setLanguage('hi-IN');
    await tts.setPitch(1.0);
    await tts.setSpeechRate(0.45);

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> startListening() async {
    if (!available) {
      await initializeVoice();
    }

    if (!available) {
      setState(() {
        message = 'Speech recognition unavailable';
      });
      return;
    }

    await tts.stop();

    setState(() {
      listening = true;
      message = 'Listening...';
      recognizedText = '';
    });

    await speech.listen(
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 3),
      onResult: (result) {
        setState(() {
          recognizedText = result.recognizedWords;
        });

        if (result.finalResult) {
          respondToUser(result.recognizedWords);
        }
      },
    );
  }

  Future<void> respondToUser(String text) async {
    await speech.stop();

    if (!mounted) return;

    setState(() {
      listening = false;
      message = text.isEmpty ? 'I could not hear you.' : 'You said:';
    });

    if (text.isNotEmpty) {
      await tts.speak('आपने कहा $text');
    }
  }

  Future<void> toggleListening() async {
    if (listening) {
      await speech.stop();
      setState(() {
        listening = false;
        message = 'Voice stopped';
      });
    } else {
      await startListening();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    speech.stop();
    tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030916),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 35),

            const Text(
              'JARVIS AI',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 6,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'YOUR PERSONAL AI ASSISTANT',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 10,
                letterSpacing: 3,
              ),
            ),

            const Spacer(),

            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: controller.value * 6.28318,
                  child: Container(
                    width: 285,
                    height: 285,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.cyanAccent.withOpacity(0.8),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyanAccent.withOpacity(0.25),
                          blurRadius: 35,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: child,
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF07182B),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/jarvis_avatar.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.smart_toy,
                        color: Colors.cyanAccent,
                        size: 100,
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              'Hello! I am Jarvis.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 14,
                ),
              ),
            ),

            if (recognizedText.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  recognizedText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 16,
                  ),
                ),
              ),

            const Spacer(),

            GestureDetector(
              onTap: toggleListening,
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: listening
                      ? Colors.cyanAccent.withOpacity(0.2)
                      : const Color(0xFF07182B),
                  border: Border.all(
                    color: Colors.cyanAccent,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyanAccent.withOpacity(0.3),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Icon(
                  listening ? Icons.mic : Icons.mic_none,
                  color: Colors.cyanAccent,
                  size: 35,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              listening ? 'LISTENING...' : 'HEY JARVIS',
              style: const TextStyle(
                color: Colors.cyanAccent,
                fontSize: 17,
                letterSpacing: 5,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'TAP MICROPHONE TO SPEAK',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 10,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}

