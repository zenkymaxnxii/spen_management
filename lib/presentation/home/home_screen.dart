import 'package:flutter/material.dart';
import 'pages/pages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;
  var _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      const AddSpenPage(),
      const CalendarPage(),
      const ChartPage(),
      const MorePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      showUnselectedLabels: true,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.5),
      onTap: (value) {
        setState(() {
          _currentIndex = value;
        });
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.edit_outlined), label: "Nhập vào"),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined), label: "Lịch"),
        BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline_outlined), label: "Báo cáo"),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "Khác"),
      ],
    );
  }
}
