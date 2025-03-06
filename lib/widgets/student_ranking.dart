import 'package:flutter/material.dart';
import '../widgets/custom_icons.dart';
import '../models/student_model.dart';

class StudentRanking extends StatefulWidget {
  const StudentRanking({super.key});

  @override
  State<StudentRanking> createState() => _StudentRankingState();
}

class _StudentRankingState extends State<StudentRanking> {
  final List<StudentModel> _rankingData = [
    StudentModel(
        id: '1',
        name: 'Emma Petit',
        className: '3ème A',
        average: 17.8,
        rank: 1),
    StudentModel(
        id: '2',
        name: 'Sophie Martin',
        className: '3ème B',
        average: 16.5,
        rank: 2),
    StudentModel(
        id: '3',
        name: 'Thomas Dubois',
        className: '3ème B',
        average: 14.2,
        rank: 3),
    StudentModel(
        id: '4',
        name: 'Chloé Moreau',
        className: '3ème C',
        average: 15.3,
        rank: 4),
    StudentModel(
        id: '5',
        name: 'Lucas Bernard',
        className: '3ème A',
        average: 12.5,
        rank: 5),
    StudentModel(
        id: '6', name: 'Léa Roux', className: '3ème C', average: 11.8, rank: 6),
    StudentModel(
        id: '7',
        name: 'Hugo Leroy',
        className: '3ème B',
        average: 10.5,
        rank: 7),
    StudentModel(
        id: '8',
        name: 'Camille Girard',
        className: '3ème A',
        average: 9.7,
        rank: 8),
  ];

  String _selectedClass = 'Toutes les classes';
  String _selectedPeriod = '1er Trimestre';
  bool _classDropdownOpen = false;
  bool _periodDropdownOpen = false;

  final List<String> _classes = [
    'Toutes les classes',
    '3ème A',
    '3ème B',
    '3ème C'
  ];
  final List<String> _periods = [
    '1er Trimestre',
    '2ème Trimestre',
    '3ème Trimestre',
    'Année complète'
  ];

  List<StudentModel> get _filteredRanking {
    if (_selectedClass == 'Toutes les classes') {
      return _rankingData;
    } else {
      return _rankingData
          .where((student) => student.className == _selectedClass)
          .toList();
    }
  }

  Color _getGradeColor(double average) {
    if (average >= 16) return const Color(0xFF2196F3);
    if (average >= 14) return const Color(0xFF4CAF50);
    if (average >= 12) return const Color(0xFFFFC107);
    return const Color(0xFFF44336);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          _buildHeader(),
          _buildFilters(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: _filteredRanking.length,
              itemBuilder: (context, index) {
                return _buildRankingItem(_filteredRanking[index], index);
              },
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
      child: const Text(
        'Classement des élèves',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Classe:',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 5),
                _buildDropdown(
                  _selectedClass,
                  () {
                    setState(() {
                      _classDropdownOpen = !_classDropdownOpen;
                      _periodDropdownOpen = false;
                    });
                  },
                  _classDropdownOpen,
                  _classes,
                  (value) {
                    setState(() {
                      _selectedClass = value;
                      _classDropdownOpen = false;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Période:',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 5),
                _buildDropdown(
                  _selectedPeriod,
                  () {
                    setState(() {
                      _periodDropdownOpen = !_periodDropdownOpen;
                      _classDropdownOpen = false;
                    });
                  },
                  _periodDropdownOpen,
                  _periods,
                  (value) {
                    setState(() {
                      _selectedPeriod = value;
                      _periodDropdownOpen = false;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String selectedValue,
    VoidCallback onTap,
    bool isOpen,
    List<String> items,
    Function(String) onItemSelected,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedValue,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF333333),
                  ),
                ),
                const Icon(
                  CustomIcons.chevronDown,
                  size: 16,
                  color: Color(0xFF666666),
                ),
              ],
            ),
          ),
        ),
        if (isOpen)
          Container(
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: items.map((item) {
                return GestureDetector(
                  onTap: () => onItemSelected(item),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: const Color(0xFFF0F0F0),
                          width: 1,
                          style: item == items.last
                              ? BorderStyle.none
                              : BorderStyle.solid,
                        ),
                      ),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 14,
                        color: item == selectedValue
                            ? const Color(0xFF3498DB)
                            : const Color(0xFF333333),
                        fontWeight: item == selectedValue
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildRankingItem(StudentModel student, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: index == 0
                  ? const Color(0xFFF1C40F)
                  : index == 1
                      ? const Color(0xFFBDC3C7)
                      : index == 2
                          ? const Color(0xFFD35400)
                          : const Color(0xFFECF0F1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: index < 3
                  ? const Icon(
                      CustomIcons.award,
                      size: 16,
                      color: Colors.white,
                    )
                  : Text(
                      student.rank.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF666666),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  student.className,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              student.average.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _getGradeColor(student.average),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
