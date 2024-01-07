import 'package:evenmt_sportif/model/evenement.dart';
import 'package:evenmt_sportif/presentation/pages/AjouterEvenemnt.dart';
import 'package:evenmt_sportif/presentation/pages/List_all_participant.dart';
import 'package:evenmt_sportif/presentation/pages/List_participant.dart';
import 'package:flutter/material.dart';

class MyEditDetailPage extends StatelessWidget {
  
  final Evenements eventModel;

  const MyEditDetailPage({required this.eventModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
          backgroundColor: const Color(0xFF5569FE),
            
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
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
Widget _buildDescription(Evenements eventModel, BuildContext context) => Container(
  margin: const EdgeInsets.only(top: 10),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        eventModel.name,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          const Icon(Icons.add_location_alt_outlined),
          const SizedBox(width: 4),
          Text(
            eventModel.lieu,
            style: const TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 77, 77, 77),
            ),
          )
        ],
      ),
      const SizedBox(height: 10),
      const Text(
        "Regles :",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 100,
        child: Text(eventModel.regle),
      ),
       SizedBox(
        width: 350,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5569FE),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  ListAllPartipant(eventModel: eventModel),
              ),
            );
          },
          child: const Text(" list of  participants"),
        ),
      ),
      SizedBox(
        width: 350,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5569FE),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  ListParticipantPage(eventModel: eventModel),
              ),
            );
          },
          child: const Text("Check list participants"),
        ),
      ),
      SizedBox(
        width: 350,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5569FE),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AjouterEvent(eventModel: eventModel),
              ),
            );
          },
          child: const Text("Modifier"),
        ),
      ),
    ],
  ),
);
}
