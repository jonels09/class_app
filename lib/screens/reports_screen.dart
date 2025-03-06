import 'package:flutter/material.dart';
import '../widgets/report_card.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ReportCard(),
    );
  }
}