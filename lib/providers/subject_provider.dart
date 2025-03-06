import 'package:flutter/foundation.dart';
import '../models/subject_model.dart';

class SubjectProvider with ChangeNotifier {
  final List<SubjectModel> _subjects = [
    SubjectModel(
        id: '1',
        name: 'Mathématiques',
        responsable: 'Marie Dupont',
        coefficient: 4),
    SubjectModel(
        id: '2',
        name: 'Français',
        responsable: 'Martin lemena',
        coefficient: 4),
    SubjectModel(
        id: '3',
        name: 'Histoire-Géographie',
        responsable: 'Martin lemena',
        coefficient: 3),
    SubjectModel(
        id: '4',
        name: 'Sciences Physiques',
        responsable: 'Martin lemena',
        coefficient: 3),
    SubjectModel(
        id: '5', name: 'SVT', responsable: 'Martin lemena', coefficient: 2),
    SubjectModel(
        id: '6', name: 'Anglais', responsable: 'Martin lemena', coefficient: 2),
    SubjectModel(
        id: '7',
        name: 'Espagnol',
        responsable: 'Martin lemena',
        coefficient: 2),
    SubjectModel(
        id: '8', name: 'EPS', responsable: 'Martin lemena', coefficient: 1),
  ];

  List<SubjectModel> get subjects => _subjects;

  SubjectModel? getSubjectById(String id) {
    try {
      return _subjects.firstWhere((subject) => subject.id == id);
    } catch (e) {
      return null;
    }
  }

  void addSubject(SubjectModel subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  void updateSubject(SubjectModel updatedSubject) {
    final index =
        _subjects.indexWhere((subject) => subject.id == updatedSubject.id);
    if (index != -1) {
      _subjects[index] = updatedSubject;
      notifyListeners();
    }
  }

  void deleteSubject(String id) {
    _subjects.removeWhere((subject) => subject.id == id);
    notifyListeners();
  }
}
