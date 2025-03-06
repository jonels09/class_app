class ReportModel {
  final String id;
  final String name;
  final String className;
  final String period;
  final String schoolYear;
  final double generalAverage;
  final int classRank;
  final int classSize;
  final String teacherComment;
  final String principalComment;
  final List<SubjectReportModel> subjects;

  ReportModel({
    required this.id,
    required this.name,
    required this.className,
    required this.period,
    required this.schoolYear,
    required this.generalAverage,
    required this.classRank,
    required this.classSize,
    required this.teacherComment,
    required this.principalComment,
    required this.subjects,
  });
}

class SubjectReportModel {
  final String name;
  final int coefficient;
  final List<int> grades;
  final double average;
  final double classAverage;
  final String teacherComment;

  SubjectReportModel({
    required this.name,
    required this.coefficient,
    required this.grades,
    required this.average,
    required this.classAverage,
    required this.teacherComment,
  });
}
