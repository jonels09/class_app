import 'package:class_app/models/student_model.dart';
import 'package:flutter/material.dart';

class StudentProvider extends ChangeNotifier {
  final List<StudentModel> _students = [
    StudentModel(
      id: '1',
      name: 'Sophie Martin',
      className: '3ème B',
      average: 16.5,
    ),
    StudentModel(
      id: '2',
      name: 'Thomas Dubois',
      className: '3ème B',
      average: 14.2,
    ),
    StudentModel(
      id: '3',
      name: 'Emma Petit',
      className: '3ème A',
      average: 17.8,
    ),
    StudentModel(
      id: '4',
      name: 'Lucas Bernard',
      className: '3ème A',
      average: 12.5,
    ),
    StudentModel(
      id: '5',
      name: 'Chloé Moreau',
      className: '3ème C',
      average: 15.3,
    ),
  ];

  List<StudentModel> get students => _students;

  List<StudentModel> getStudentsByClass(String className) {
    if (className == 'Toutes les classes') {
      return _students;
    }
    return _students
        .where((student) => student.className == className)
        .toList();
  }

  StudentModel? getStudentById(String id) {
    try {
      return _students.firstWhere((student) => student.id == id);
    } catch (e) {
      return null;
    }
  }

  void addStudent(StudentModel student) {
    _students.add(student);
    notifyListeners();
  }

  void updateStudent(StudentModel updatedStudent) {
    final index =
        _students.indexWhere((student) => student.id == updatedStudent.id);
    if (index != -1) {
      _students[index] = updatedStudent;
      notifyListeners();
    }
  }

  void deleteStudent(String id) {
    _students.removeWhere((student) => student.id == id);
    notifyListeners();
  }
}
