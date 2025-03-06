import 'package:flutter/material.dart';
import '../widgets/custom_icons.dart';
import '../models/student_model.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
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
      name: 'RAHARIVELO Noëlson Julio',
      className: '3ème A',
      average: 12.5,
    ),
    StudentModel(
      id: '5',
      name: 'NIRINTSOA Noëlson Manambina Tséfanh ',
      className: '3ème C',
      average: 15.3,
    ),
  ];

  List<StudentModel> _filteredStudents = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredStudents = List.from(_students);
    _searchController.addListener(_filterStudents);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterStudents() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredStudents = List.from(_students);
      } else {
        _filteredStudents = _students.where((student) {
          return student.name.toLowerCase().contains(query) ||
              student.className.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  Color _getGradeColor(double average) {
    if (average >= 16) return const Color(0xFFE3F2FD);
    if (average >= 14) return const Color(0xFFE8F5E9);
    if (average >= 12) return const Color(0xFFFFF8E1);
    return const Color(0xFFFFEBEE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 20),
            _buildListHeader(),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredStudents.length,
                itemBuilder: (context, index) {
                  return _buildStudentItem(_filteredStudents[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Rechercher un élève...',
                border: InputBorder.none,
                prefixIcon: Icon(
                  CustomIcons.search,
                  color: Color(0xFF999999),
                  size: 20,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
              ),
            ),
          ),
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: const Icon(
            CustomIcons.plus,
            color: Color(0xFF3498DB),
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildListHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Liste des élèves',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        Text(
          '${_filteredStudents.length} élèves',
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _buildStudentItem(StudentModel student, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Remplacer l'image par un numéro
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xFFE3F2FD),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3498DB),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      student.className,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _handleEditStudent(student),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(
                              CustomIcons.edit,
                              size: 16,
                              color: Color(0xFF3498DB),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () => _handleDeleteStudent(student.id),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEBEE),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(
                              CustomIcons.trash,
                              size: 16,
                              color: Color(0xFFE74C3C),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Icon(
            CustomIcons.chevronRight,
            size: 20,
            color: Color(0xFF999999),
          ),
        ],
      ),
    );
  }

  void _handleEditStudent(StudentModel student) {
    // Logique d'édition
  }

  void _handleDeleteStudent(String id) {
    // Logique de suppression
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content: const Text('Voulez-vous vraiment supprimer cet élève ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              // Implémenter la suppression réelle ici
              Navigator.pop(context);
            },
            child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
