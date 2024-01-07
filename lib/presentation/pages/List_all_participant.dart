import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:evenmt_sportif/model/evenement.dart';
class ListAllPartipant extends StatefulWidget {
  final Evenements eventModel;

  const ListAllPartipant({Key? key, required this.eventModel}) : super(key: key);

  @override
  State<ListAllPartipant> createState() => _ListAllPartipantState();
}

class _ListAllPartipantState extends State<ListAllPartipant> {
  late List<String> participantEmails = []; 

  @override
  void initState() {
    super.initState();
    _retrieveParticipantEmails();
  }

  void _retrieveParticipantEmails() {
    // Check if participants list is not null
    if (widget.eventModel.participants != null) {
      // Assign the list of participants to participantEmails
      participantEmails = List<String>.from(widget.eventModel.participants!);
    }
  }

  void _removeParticipant(String email) {
    setState(() {
      // Remove the participant from the list
      participantEmails.remove(email);
    });

    // Update the participants list in Firestore
    FirebaseFirestore.instance
        .collection('événements')
        .doc(widget.eventModel.id)
        .update({
      'participants': participantEmails,
      'nbrpartiactul': FieldValue.increment(-1)
    }).then((value) {
      print('Participant removed successfully.');
    }).catchError((error) {
      print('Error removing participant: $error');
      // Handle error as needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List participants"),
        backgroundColor: const Color(0xFF5569FE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _participantList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _participantList() {
    if (participantEmails.isEmpty) {
      // If the participant list is empty, display a message at the center
      return const Center(
        child: Text(
          "No participants",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    } else {
      // If there are participants, display the list
      return Expanded(
        child: ListView.builder(
          itemCount: participantEmails.length,
          itemBuilder: (context, index) {
            final participantEmail = participantEmails[index];

            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text((index + 1).toString()),
              ),
              title: Text(participantEmail),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Handle rejection logic here
                      _removeParticipant(participantEmail);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }
}
