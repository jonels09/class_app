import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/grades_screen.dart';
import '../screens/ranking_screen.dart';
import '../screens/reports_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/notifications_screen.dart';
import '../widgets/custom_icons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const GradesScreen(),
    const RankingScreen(),
    const ReportsScreen(),
    const ProfileScreen(),
    const NotificationsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF3498DB),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.graduationCap),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.award),
            label: 'Classement',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.fileText),
            label: 'Bulletins',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.user),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.bell),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}
