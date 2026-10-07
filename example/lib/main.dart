import 'package:flutter/material.dart';
import 'package:premium_reveal/premium_reveal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Premium Reveal Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5A2E2E)),
        useMaterial3: true,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: PremiumPageTransitionsBuilder(),
            TargetPlatform.iOS: PremiumPageTransitionsBuilder(),
          },
        ),
      ),
      home: const DemoHomeScreen(),
    );
  }
}

class DemoHomeScreen extends StatelessWidget {
  const DemoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EC),
      appBar: AppBar(
        title: const Text('Premium Reveal Demo'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: PremiumStaggeredColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text('Hero Banner Card',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              const Text('Explore Options',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              const Text('Notice how each element gently cascades into view.',
                  style: TextStyle(color: Colors.black54)),
              const SizedBox(height: 16),
              for (int i = 1; i <= 4; i++)
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFFEEE2E2),
                        child: Text('$i',
                            style: const TextStyle(color: Color(0xFF5A2E2E))),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text('Staggered item number $i in sequence'),
                      ),
                      const Icon(Icons.chevron_right, color: Colors.black38),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
