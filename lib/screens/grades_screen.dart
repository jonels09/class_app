import 'package:flutter/material.dart';
import '../widgets/grade_entry.dart';

class GradesScreen extends StatelessWidget {
  const GradesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GradeEntry(),
    );
  }
}