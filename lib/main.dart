import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/azkar_screen.dart';
import 'screens/quran_screen.dart';
import 'screens/prayer_times_screen.dart';
import 'screens/tasbeeh_screen.dart';
import 'screens/prayer_guide_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SkoonApp());
}

class SkoonApp extends StatelessWidget {
  const SkoonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skoon - سُكون',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ar', '')],
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F9F6),
        primaryColor: const Color(0xFF8A9A86),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8A9A86)),
      ),
      home: const MainHomeScreen(),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  // ربط جميع الشاشات الـ 5 معاً في شريط التنقل السفلي
  final List<Widget> _pages = [
    const AzkarScreen(),        // 1. الأذكار والنصائح اليومية
    const QuranAudioScreen(),   // 2. القرآن الكريم (7 قراء)
    const PrayerTimesScreen(),  // 3. مواقيت الصلاة والموقع
    const TasbeehScreen(),      // 4. السبحة الإلكترونية
    const PrayerGuideScreen(),  // 5. تعليم الصلاة والوضوء
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سُكون | Skoon', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF8A9A86),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF5A7052),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'الأذكار'),
          BottomNavigationBarItem(icon: Icon(Icons.headphones), label: 'القرآن'),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'الصلاة'),
          BottomNavigationBarItem(icon: Icon(Icons.fingerprint), label: 'السبحة'),
          BottomNavigationBarItem(icon: Icon(Icons.clean_hands), label: 'التعليم'),
        ],
      ),
    );
  }
}