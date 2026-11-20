import 'package:flutter/material.dart';

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

class JarvisHome extends StatelessWidget {
  const JarvisHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050B16),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.auto_awesome,
                color: Colors.cyanAccent,
                size: 55,
              ),
              const SizedBox(height: 15),
              const Text(
                'JARVIS AI',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your Personal AI Assistant',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 65),
              Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.cyanAccent,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyanAccent.withOpacity(0.25),
                      blurRadius: 35,
                      spreadRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.mic,
                  color: Colors.cyanAccent,
                  size: 75,
                ),
              ),
              const SizedBox(height: 35),
              const Text(
                'Hello! I am Jarvis.',
                style: TextStyle(fontSize: 21),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your assistant is ready.',
                style: TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 45),
              const Text(
                'VOICE SYSTEM COMING SOON',
                style: TextStyle(
                  color: Colors.cyanAccent,
                  letterSpacing: 2,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
