import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen1.dart';
import 'screen2.dart';
import 'screen3.dart';
import 'screen4.dart';

void main() => runApp(const MyApp());

class TabModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void select(int index) {
    if (index == _currentIndex) return;
    _currentIndex = index;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TabModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavLab(),
      ),
    );
  }
}

class BottomNavLab extends StatelessWidget {
  const BottomNavLab({super.key});

  static const List<Widget> _screens = [
    Screen1(),
    Screen2(),
    Screen3(),
    Screen4(),
  ];

  @override
  Widget build(BuildContext context) {
    final int currentIndex = context.watch<TabModel>().currentIndex;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Navigation Bar'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _screens[currentIndex],
      body: SafeArea(child: screens[currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.white,
        backgroundColor: Colors.blue,
        iconSize: 30,
        currentIndex: currentIndex,
        onTap: (int index) {
          context.read<TabModel>().select(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Alarm'),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
        ],
      ),
    );
  }
}
