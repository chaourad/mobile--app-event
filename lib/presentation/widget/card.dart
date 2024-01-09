import 'package:evenmt_sportif/model/evenement.dart';
import 'package:evenmt_sportif/presentation/pages/MyEventDetailEdit.dart';
import 'package:evenmt_sportif/presentation/widget/StackParticipant.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

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
            builder: (context) => DetailsPage(
                eventModel: eventModel), // Pass eventData to the details page
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
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
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
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
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

  const CardMyEvent({
    Key? key,
    required this.eventModel,
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
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
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

class DetailsPage extends StatelessWidget {
  final Evenements eventModel;

  const DetailsPage({required this.eventModel, Key? key}) : super(key: key);

  void _shareEvent(BuildContext context) {
    final String text =
        'Check out this event: ${eventModel.name}, happening at ${eventModel.lieu} on ${eventModel.createdat}!';
    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Details"),
        backgroundColor: const Color(0xFF5569FE), 
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share event
              _shareEvent(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardImage(eventModel),
              const SizedBox(height: 16),
              _buildDescription(eventModel, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardImage(Evenements eventModel) => Stack(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  eventModel.image,
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 22,
            child: Container(
              height: 65,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.white,
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
                    "Feb",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );

  Widget _buildDescription(Evenements eventModel, BuildContext context) =>
      Container(
        margin: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventModel.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 8),
                Text(
                  eventModel.lieu,
                  style: const TextStyle(
                    fontSize: 16, 
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const StackParticipant(
                  width: 30, 
                  height: 30,
                  fontSize: 16, 
                  positionText: 110,
                ),
                const SizedBox(
                  width: 90,
                ),
                Text(
                  '${eventModel.nbrpartiactul} Participants',
                  style: const TextStyle(
                    color: Color(0xFF5569FE),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Rules:",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              eventModel.regle,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
}
