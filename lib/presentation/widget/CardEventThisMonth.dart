import 'package:evenmt_sportif/model/evenement.dart';
import 'package:evenmt_sportif/presentation/pages/EventDetailsPage.dart';
import 'package:evenmt_sportif/presentation/widget/StackParticipant.dart';
import 'package:flutter/material.dart';

class CardEventThisMonth extends StatelessWidget {
  final Evenements eventModel;

  const CardEventThisMonth({required this.eventModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsPage(eventModel: eventModel),
          ),
        );
      },
      child: Container(
        height: 90,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                eventModel.image,
                fit: BoxFit.cover,
                width: 60,
                height: double.infinity,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventModel.name,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
const Icon(Icons.location_on),                    const SizedBox(width: 4),
                    Text(
                      eventModel.lieu,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                const Expanded(
                  child: StackParticipant(
                    width: 25,
                    height: 25,
                    fontSize: 12,
                    positionText: 95,
                  ),
                )
              ],
            ),
            const Spacer(),
            Container(
              height: 50,
              width: 35,
              decoration: BoxDecoration(
                color:const Color.fromARGB(255, 190, 194, 224),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "11",
                  ),
                  Text(
                    "22",
                    style: TextStyle(
                      color: Colors.black,
                    ),
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
