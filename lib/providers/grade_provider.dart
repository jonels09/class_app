
import 'package:flutter/material.dart';

class GradeProvider extends ChangeNotifier {
  // Map structure: studentId -> subjectId -> List of grades
  final Map<String, Map<String, List<double>>> _grades = {
    '1': { // Sophie Martin
      '1': [18, 16, 15], // Mathématiques
      '2': [15, 17, 14], // Français
      '3': [14, 16, 15], // Histoire-Géographie
      '4': [19, 17, 18], // Sciences Physiques
      '5': [16, 15, 17], // SVT
      '6': [18, 19, 17], // Anglais
      '7': [14, 15, 16], // Espagnol
      '8': [17, 18, 16], // EPS
    },
    '2': { // Thomas Dubois
      '1': [14, 13, 15], // Mathématiques
      '2': [16, 15, 14], // Français
      '3': [12, 14, 13], // Histoire-Géographie
      '4': [15, 14, 16], // Sciences Physiques
      '5': [13, 14, 12], // SVT
      '6': [15, 16, 14], // Anglais
      '7': [12, 13, 14], // Espagnol
      '8': [16, 15, 17], // EPS
    },
  };

  List<double> getGrades(String studentId, String subjectId) {
    if (_grades.containsKey(studentId) && _grades[studentId]!.containsKey(subjectId)) {
      return _grades[studentId]![subjectId]!;
    }
    return [];
  }

  double getAverage(String studentId, String subjectId) {
    final grades = getGrades(studentId, subjectId);
    if (grades.isEmpty) return 0;
    
    final sum = grades.reduce((a, b) => a + b);
    return sum / grades.length;
  }

  double getStudentAverage(String studentId, Map<String, int> coefficients) {
    if (!_grades.containsKey(studentId)) return 0;
    
    double totalPoints = 0;
    int totalCoefficients = 0;
    
    _grades[studentId]!.forEach((subjectId, grades) {
      if (coefficients.containsKey(subjectId) && grades.isNotEmpty) {
        final average = grades.reduce((a, b) => a + b) / grades.length;
        final coefficient = coefficients[subjectId]!;
        
        totalPoints += average * coefficient;
        totalCoefficients += coefficient;
      }
    });
    
    if (totalCoefficients == 0) return 0;
    return totalPoints / totalCoefficients;
  }

  void addGrade(String studentId, String subjectId, double grade) {
    if (!_grades.containsKey(studentId)) {
      _grades[studentId] = {};
    }
    
    if (!_grades[studentId]!.containsKey(subjectId)) {
      _grades[studentId]![subjectId] = [];
    }
    
    _grades[studentId]![subjectId]!.add(grade);
    notifyListeners();
  }

  void updateGrade(String studentId, String subjectId, int index, double newGrade) {
    if (_grades.containsKey(studentId) && 
        _grades[studentId]!.containsKey(subjectId) && 
        index < _grades[studentId]![subjectId]!.length) {
      _grades[studentId]![subjectId]![index] = newGrade;
      notifyListeners();
    }
  }

  void deleteGrade(String studentId, String subjectId, int index) {
    if (_grades.containsKey(studentId) && 
        _grades[studentId]!.containsKey(subjectId) && 
        index < _grades[studentId]![subjectId]!.length) {
      _grades[studentId]![subjectId]!.removeAt(index);
      notifyListeners();
    }
  }
}