class StudentModel {
  final String id;
  final String name;
  final String className;
  final double average;
  final int? rank;

  StudentModel({
    required this.id,
    required this.name,
    required this.className,
    required this.average,
    this.rank,
  });
}
