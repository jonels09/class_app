import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_icons.dart';
import '../models/subject_model.dart';
import '../providers/subject_provider.dart';

class SubjectManagement extends StatefulWidget {
  const SubjectManagement({super.key});

  @override
  State<SubjectManagement> createState() => _SubjectManagementState();
}

class _SubjectManagementState extends State<SubjectManagement> {
  bool _modalVisible = false;
  SubjectModel? _editingSubject;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _responsableController = TextEditingController();
  final TextEditingController _coefficientController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _responsableController.dispose();
    _coefficientController.dispose();
    super.dispose();
  }

  void _openAddModal() {
    setState(() {
      _editingSubject = null;
      _nameController.text = '';
      _responsableController.text = '';
      _coefficientController.text = '';
      _modalVisible = true;
    });
  }

  void _openEditModal(SubjectModel subject) {
    setState(() {
      _editingSubject = subject;
      _nameController.text = subject.name;
      _responsableController.text = subject.responsable;
      _coefficientController.text = subject.coefficient.toString();
      _modalVisible = true;
    });
  }

  void _handleSave() {
    final provider = Provider.of<SubjectProvider>(context, listen: false);

    if (_nameController.text.isEmpty ||
        _responsableController.text.isEmpty ||
        _coefficientController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tous les champs sont obligatoires'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final coefficient = int.tryParse(_coefficientController.text);
    if (coefficient == null || coefficient < 1 || coefficient > 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Le coefficient doit être un nombre entre 1 et 10'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_editingSubject != null) {
      final updatedSubject = SubjectModel(
        id: _editingSubject!.id,
        name: _nameController.text,
        responsable: _responsableController.text,
        coefficient: coefficient,
      );
      provider.updateSubject(updatedSubject);
    } else {
      final newSubject = SubjectModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        responsable: _responsableController.text,
        coefficient: coefficient,
      );
      provider.addSubject(newSubject);
    }

    setState(() {
      _modalVisible = false;
    });
  }

  void _handleDelete(String id) {
    final provider = Provider.of<SubjectProvider>(context, listen: false);
    provider.deleteSubject(id);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SubjectProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: provider.subjects.length,
                  itemBuilder: (context, index) =>
                      _buildSubjectItem(provider.subjects[index]),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: _buildAddButton(),
            ),
          ),
          if (_modalVisible) _buildModal(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      color: const Color(0xFF2C3E50),
      child: const Text(
        'Gestion des matières',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSubjectItem(SubjectModel subject) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subject.responsable,
                      style: const TextStyle(
                          fontSize: 14, color: Color(0xFF666666)),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Coefficient au-dessus des icônes
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Coef. ${subject.coefficient}',
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF666666)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _openEditModal(subject),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                              color: const Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.circular(18)),
                          child: const Icon(CustomIcons.edit,
                              size: 16, color: Color(0xFF3498DB)),
                        ),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => _handleDelete(subject.id),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFFEBEE),
                              borderRadius: BorderRadius.circular(18)),
                          child: const Icon(CustomIcons.trash,
                              size: 16, color: Color(0xFFE74C3C)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: _openAddModal,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFF3498DB),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          CustomIcons.plus,
          size: 24,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildModal() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _modalVisible = false;
        });
      },
      child: Container(
        color: Colors.black.withOpacity(0.5),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _editingSubject != null
                            ? 'Modifier une matière'
                            : 'Ajouter une matière',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _modalVisible = false;
                          });
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            CustomIcons.close,
                            size: 24,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildFormField(
                    'Nom de la matière',
                    'Ex: Mathématiques',
                    _nameController,
                  ),
                  const SizedBox(height: 15),
                  _buildFormField(
                    'Responsable',
                    'Ex: Jean Martin',
                    _responsableController,
                  ),
                  const SizedBox(height: 15),
                  _buildFormField(
                    'Coefficient (1-10)',
                    'Ex: 4',
                    _coefficientController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _modalVisible = false;
                          });
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                          side: const BorderSide(color: Color(0xFFDDDDDD)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Annuler',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _handleSave,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3498DB),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        icon: const Icon(
                          CustomIcons.save,
                          size: 18,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Enregistrer',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(
    String label,
    String hint,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12,
              ),
            ),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
