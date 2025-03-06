import 'package:flutter/material.dart';
import '../widgets/custom_icons.dart';
import '../models/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: '1',
      title: 'Nouvelle note ajoutée',
      message:
          'Une note de mathématiques a été ajoutée pour la classe de 3ème B',
      time: 'Il y a 10 minutes',
      read: false,
      type: 'grade',
    ),
    NotificationModel(
      id: '2',
      title: 'Réunion des enseignants',
      message: 'Rappel: Réunion des enseignants demain à 14h00 en salle 103',
      time: 'Il y a 2 heures',
      read: false,
      type: 'meeting',
    ),
    NotificationModel(
      id: '3',
      title: 'Bulletin trimestriel',
      message:
          'Les bulletins du 1er trimestre sont disponibles pour validation',
      time: 'Hier',
      read: true,
      type: 'report',
    ),
    NotificationModel(
      id: '4',
      title: 'Nouvel élève',
      message: 'Un nouvel élève a été ajouté à votre classe de 1ère S',
      time: 'Il y a 2 jours',
      read: true,
      type: 'student',
    ),
    NotificationModel(
      id: '5',
      title: 'Absence signalée',
      message:
          'Marie Dupont sera absente du 15 au 20 octobre pour raisons médicales',
      time: 'Il y a 3 jours',
      read: true,
      type: 'absence',
    ),
  ];

  String _selectedFilter = 'Tous';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          _buildHeader(),
          _buildFilterBar(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationItem(_notifications[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      color: const Color(0xFF2C3E50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Notifications',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Stack(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  CustomIcons.bell,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE74C3C),
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: const Center(
                    child: Text(
                      '2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildFilterButton('Tous', isActive: _selectedFilter == 'Tous'),
          _buildFilterButton('Non lus', isActive: _selectedFilter == 'Non lus'),
          _buildFilterButton('Importants',
              isActive: _selectedFilter == 'Importants'),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text, {required bool isActive}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = text;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF3498DB) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF666666),
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(NotificationModel notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
        border: notification.read
            ? null
            : const Border(
                left: BorderSide(
                  color: Color(0xFF3498DB),
                  width: 4,
                ),
              ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                      if (!notification.read)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF3498DB),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    notification.message,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    notification.time,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                _buildActionButton(CustomIcons.check, const Color(0xFF4CAF50)),
                const SizedBox(height: 10),
                _buildActionButton(CustomIcons.x, const Color(0xFFF44336)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(
        icon,
        size: 18,
        color: color,
      ),
    );
  }
}
