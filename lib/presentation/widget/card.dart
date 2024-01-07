import 'package:evenmt_sportif/model/evenement.dart';
import 'package:evenmt_sportif/presentation/pages/EventDetailsPage.dart';
import 'package:evenmt_sportif/presentation/pages/MyEventDetailEdit.dart';
import 'package:flutter/material.dart';

class CardSp extends StatelessWidget {
    final Evenements eventModel;

  const CardSp({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsPage(eventModel: eventModel), // Pass eventData to the details page
          ),
        );
      },
      child: Container(
        width: 150, 
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100, 
              decoration: BoxDecoration(
                borderRadius:const BorderRadius.vertical(top: Radius.circular(12)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(eventModel.image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventModel.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    eventModel.lieu,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardMyEvent extends StatelessWidget {
  final Evenements eventModel;
  final bool showNotificationButton; // Nouveau paramètre

  const CardMyEvent({
    Key? key,
    required this.eventModel,
    required this.showNotificationButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyEditDetailPage(eventModel: eventModel),
          ),
        );
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(eventModel.image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventModel.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    eventModel.lieu,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            if (showNotificationButton) // Afficher le bouton rouge si showNotificationButton est vrai
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
                ),
                child: Center(
                  child: Text(
                    'New Notification',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
