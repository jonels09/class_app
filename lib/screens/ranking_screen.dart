import 'package:flutter/material.dart';
import '../widgets/student_ranking.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StudentRanking(),
    );
  }
}