import 'package:flutter/material.dart';
import '../widgets/custom_icons.dart';
import '../models/report_model.dart';

class ReportCard extends StatefulWidget {
  const ReportCard({super.key});

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  final ReportModel _studentData = ReportModel(
    id: '1',
    name: 'Sophie Martin',
    className: '3ème B',
    period: '1er Trimestre',
    schoolYear: '2024-2025',
    generalAverage: 16.5,
    classRank: 2,
    classSize: 28,
    teacherComment:
        "Sophie est une élève sérieuse et appliquée. Elle participe activement en classe et rend des travaux de qualité. Elle doit maintenir ses efforts pour progresser davantage.",
    principalComment: "Bon trimestre dans l'ensemble. Continuez ainsi.",
    subjects: [
      SubjectReportModel(
        name: 'Mathématiques',
        coefficient: 4,
        grades: [18, 16, 15],
        average: 16.3,
        classAverage: 13.2,
        teacherComment:
            "Excellent travail. Sophie maîtrise bien les concepts mathématiques.",
      ),
      SubjectReportModel(
        name: 'Français',
        coefficient: 4,
        grades: [15, 17, 14],
        average: 15.3,
        classAverage: 12.8,
        teacherComment:
            "Bonne participation à l'oral. Les analyses de textes sont pertinentes.",
      ),
      SubjectReportModel(
        name: 'Histoire-Géographie',
        coefficient: 3,
        grades: [14, 16, 15],
        average: 15.0,
        classAverage: 11.5,
        teacherComment: "Bon travail. Les connaissances sont bien assimilées.",
      ),
      SubjectReportModel(
        name: 'Sciences Physiques',
        coefficient: 3,
        grades: [19, 17, 18],
        average: 18.0,
        classAverage: 12.3,
        teacherComment:
            "Excellent niveau. Sophie montre un réel intérêt pour les sciences.",
      ),
      SubjectReportModel(
        name: 'SVT',
        coefficient: 2,
        grades: [16, 15, 17],
        average: 16.0,
        classAverage: 13.1,
        teacherComment:
            "Très bon travail. Les méthodes scientifiques sont bien appliquées.",
      ),
      SubjectReportModel(
        name: 'Anglais',
        coefficient: 2,
        grades: [18, 19, 17],
        average: 18.0,
        classAverage: 14.2,
        teacherComment:
            "Excellent niveau à l'écrit comme à l'oral. Continuez ainsi.",
      ),
      SubjectReportModel(
        name: 'Espagnol',
        coefficient: 2,
        grades: [14, 15, 16],
        average: 15.0,
        classAverage: 12.7,
        teacherComment: "Bonne participation. La prononciation s'améliore.",
      ),
      SubjectReportModel(
        name: 'EPS',
        coefficient: 1,
        grades: [17, 18, 16],
        average: 17.0,
        classAverage: 15.3,
        teacherComment: "Très bonne implication dans toutes les activités.",
      ),
    ],
  );

  final Map<String, bool> _expandedSubjects = {};

  void _toggleSubject(String subjectName) {
    setState(() {
      _expandedSubjects[subjectName] =
          !(_expandedSubjects[subjectName] ?? false);
    });
  }

  String _calculateWeightedAverage() {
    double totalPoints = 0;
    int totalCoefficients = 0;

    for (var subject in _studentData.subjects) {
      totalPoints += subject.average * subject.coefficient;
      totalCoefficients += subject.coefficient;
    }

    return (totalPoints / totalCoefficients).toStringAsFixed(1);
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  _buildReportHeader(),
                  const SizedBox(height: 15),
                  _buildSummaryCard(),
                  const SizedBox(height: 15),
                  _buildSubjectsCard(),
                  const SizedBox(height: 15),
                  _buildCommentsCard(),
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
      child: const Text(
        'Bulletin Scolaire',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildReportHeader() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              CustomIcons.fileText,
              size: 32,
              color: Color(0xFF3498DB),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _studentData.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${_studentData.className} • ${_studentData.period} • ${_studentData.schoolYear}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              CustomIcons.download,
              size: 20,
              color: Color(0xFF3498DB),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    final average = _calculateWeightedAverage();
    final averageValue = double.parse(average);
    final progressWidth = (averageValue / 20) * 100;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Résumé',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text(
                    'Moyenne Générale',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    average,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3498DB),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Rang',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${_studentData.classRank}/${_studentData.classSize}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3498DB),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            height: 10,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width *
                          0.9 *
                          (progressWidth / 100) -
                      30,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3498DB),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectsCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Matières',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 15),
          ...List.generate(_studentData.subjects.length, (index) {
            final subject = _studentData.subjects[index];
            return _buildSubjectItem(subject);
          }),
        ],
      ),
    );
  }

  Widget _buildSubjectItem(SubjectReportModel subject) {
    final isExpanded = _expandedSubjects[subject.name] ?? false;

    return Column(
      children: [
        GestureDetector(
          onTap: () => _toggleSubject(subject.name),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFF0F0F0),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Coef. ${subject.coefficient}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      subject.average.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _getGradeColor(subject.average),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      isExpanded
                          ? CustomIcons.chevronUp
                          : CustomIcons.chevronDown,
                      size: 16,
                      color: const Color(0xFF666666),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notes:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 5),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: subject.grades.map((grade) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        '$grade/20',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF3498DB),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Moyenne élève',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          subject.average.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Moyenne classe',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          subject.classAverage.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Appréciation:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subject.teacherComment,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCommentsCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Appréciations',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Professeur Principal',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                _studentData.teacherComment,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666),
                  height: 1.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Direction',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                _studentData.principalComment,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
