import 'package:class_app/screens/students_screen.dart';
import 'package:class_app/screens/subjects_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToStudentList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StudentsScreen()),
    );
  }

  // Updated navigation function for subjects
  void _navigateToSubjects(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SubjectsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  _buildStatisticsSection(),
                  const SizedBox(height: 20),
                  _buildQuickServicesSection(context),
                  const SizedBox(height: 20),
                  _buildOptionsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      color: const Color(0xFF2C3E50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Loop HR',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Center(
              child: Text(
                '🌐',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(CustomIcons.pieChart, size: 20, color: Color(0xFF333333)),
                SizedBox(width: 8),
                Text(
                  'Statistiques Générales',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              'See All',
              style: TextStyle(
                color: Color(0xFF3498DB),
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('95%', 'Attendance', const Color(0xFFE3F2FD),
                      const Color(0xFF2196F3)),
                  _buildStatItem('80%', 'Tasks Done', const Color(0xFFE8F5E9),
                      const Color(0xFF4CAF50)),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('15 h', 'Overtime', const Color(0xFFFFF8E1),
                      const Color(0xFFFFC107)),
                  _buildStatItem('10%', 'Leave Used', const Color(0xFFF3E5F5),
                      const Color(0xFF9C27B0)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(
      String value, String label, Color bgColor, Color valueColor) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickServicesSection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF333333)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Services rapide',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Text(
              'See All',
              style: TextStyle(
                color: Color(0xFF3498DB),
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildServiceCard(
              'Liste élèves',
              CustomIcons.users,
              const Color(0xFFE3F2FD),
              const Color(0xFF2196F3),
              () => _navigateToStudentList(context),
            ),
            _buildServiceCard(
              'Liste matières',
              CustomIcons.bookOpen,
              const Color(0xFFFFF8E1),
              const Color(0xFFFFC107),
              () => _navigateToSubjects(context),
            ),
            _buildServiceCard(
              'Payslips',
              CustomIcons.receipt,
              const Color(0xFFE8F5E9),
              const Color(0xFF4CAF50),
              () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceCard(String text, IconData icon, Color bgColor,
      Color iconColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                icon,
                size: 24,
                color: iconColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF333333),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFF333333),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Options',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Text(
              'See All',
              style: TextStyle(
                color: Color(0xFF3498DB),
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            _buildOptionCard(
              'Messages',
              CustomIcons.messageSquare,
              const Color(0xFFF3E5F5),
              const Color(0xFF9C27B0),
            ),
            const SizedBox(width: 15),
            _buildOptionCard(
              'Bulletins',
              CustomIcons.pieChart,
              const Color(0xFFFFEBEE),
              const Color(0xFFF44336),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOptionCard(
      String text, IconData icon, Color bgColor, Color iconColor) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              size: 24,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF333333),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
