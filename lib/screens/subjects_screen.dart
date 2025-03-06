import 'package:flutter/material.dart';
import '../widgets/subject_management.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SubjectManagement(),
    );
  }
}
