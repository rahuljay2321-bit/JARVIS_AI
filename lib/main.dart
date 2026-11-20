
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

class JarvisHome extends StatefulWidget {
  const JarvisHome({super.key});

  @override
  State<JarvisHome> createState() => _JarvisHomeState();
}

class _JarvisHomeState extends State<JarvisHome>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
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

            const Text(
              'I am always ready to help you.',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 14,
              ),
            ),

            const Spacer(),

            const Icon(
              Icons.mic,
              color: Colors.cyanAccent,
              size: 35,
            ),

            const SizedBox(height: 10),

            const Text(
              'HEY JARVIS',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 17,
                letterSpacing: 5,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'VOICE SYSTEM COMING SOON',
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


  

