import 'package:flutter/material.dart';
import '../widgets/student_list.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StudentList(),
    );
  }
}
