import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/custom_icons.dart';
import '../models/subject_model.dart';

class GradeEntry extends StatefulWidget {
  const GradeEntry({super.key});

  @override
  State<GradeEntry> createState() => _GradeEntryState();
}

class _GradeEntryState extends State<GradeEntry> {
  final List<SubjectModel> _subjects = [
    SubjectModel(
        id: '1',
        name: 'Mathématiques',
        coefficient: 4,
        responsable: 'Marie Dupont'),
    SubjectModel(
        id: '2',
        name: 'Français',
        coefficient: 4,
        responsable: 'Martin Lemenas'),
    SubjectModel(
        id: '3',
        name: 'Histoire-Géographie',
        coefficient: 3,
        responsable: 'Martin Lemenas'),
    SubjectModel(
        id: '4',
        name: 'Sciences Physiques',
        coefficient: 3,
        responsable: 'Martin Lemenas'),
    SubjectModel(
        id: '5', name: 'SVT', coefficient: 2, responsable: 'Martin Lemenas'),
    SubjectModel(
        id: '6',
        name: 'Anglais',
        coefficient: 2,
        responsable: 'Martin Lemenas'),
    SubjectModel(
        id: '7',
        name: 'Espagnol',
        coefficient: 2,
        responsable: 'Martin Lemenas'),
    SubjectModel(
        id: '8', name: 'EPS', coefficient: 1, responsable: 'Martin Lemenas'),
  ];

  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String?> _errors = {};

  @override
  void initState() {
    super.initState();
    for (var subject in _subjects) {
      _controllers[subject.id] = TextEditingController();
      _errors[subject.id] = null;
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _validateGrade(String subjectId, String value) {
    if (value.isEmpty) {
      setState(() {
        _errors[subjectId] = null;
      });
      return;
    }

    final numValue = double.tryParse(value);
    if (numValue == null || numValue < 0 || numValue > 20) {
      setState(() {
        _errors[subjectId] = 'La note doit être entre 0 et 20';
      });
    } else {
      setState(() {
        _errors[subjectId] = null;
      });
    }
  }

  void _handleSave() {
    bool hasErrors = false;
    for (var entry in _errors.entries) {
      if (entry.value != null) {
        hasErrors = true;
        break;
      }
    }

    if (hasErrors) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez corriger les erreurs avant d\'enregistrer'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Save grades logic would go here
    print('Grades saved');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          _buildHeader(),
          _buildStudentInfo(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: _subjects.length,
              itemBuilder: (context, index) {
                final subject = _subjects[index];
                return _buildGradeItem(subject);
              },
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Saisie des notes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              CustomIcons.close,
              size: 24,
              color: Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color(0xFF2C3E50),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sophie Martin',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '3ème B',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xCCFFFFFF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeItem(SubjectModel subject) {
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
                const SizedBox(height: 5),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(5),
                      border: _errors[subject.id] != null
                          ? Border.all(color: const Color(0xFFE74C3C))
                          : null,
                    ),
                    child: TextField(
                      controller: _controllers[subject.id],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '0-20',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      onChanged: (value) => _validateGrade(subject.id, value),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    '/20',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
              if (_errors[subject.id] != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      const Icon(
                        CustomIcons.alertCircle,
                        size: 14,
                        color: Color(0xFFE74C3C),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _errors[subject.id]!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFE74C3C),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              // Cancel logic
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              side: const BorderSide(color: Color(0xFFDDDDDD)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'Annuler',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF666666),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _handleSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3498DB),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            icon: const Icon(
              CustomIcons.save,
              size: 18,
              color: Colors.white,
            ),
            label: const Text(
              'Enregistrer',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
