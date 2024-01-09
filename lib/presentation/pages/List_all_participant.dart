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
  late List<String> participantId = [];
  late List<String> participantEmails = [];

  @override
  void initState() {
    super.initState();
    _retrieveParticipantId();
    _changeparticipantIdversEmail();
  }

  void _retrieveParticipantId() {
    if (widget.eventModel.participants != null) {
      participantId = List<String>.from(widget.eventModel.participants!);
    }
  }

  void _changeparticipantIdversEmail() async {
    for (int i = 0; i < participantId.length; i++) {
      String userId = participantId[i];

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get()
          .then((value) => value.docs.first);

      String email = userSnapshot['email'];

      setState(() {
        participantEmails.add(email);
      });
    }
  }

  void _removeParticipant(String email) {
    setState(() {
      participantEmails.remove(email);
    });

    FirebaseFirestore.instance
        .collection('événements')
        .doc(widget.eventModel.id)
        .update({
      'participants': participantEmails,
      'nbrpartiactul': FieldValue.increment(-1),
    }).then((value) {
      print('Participant removed successfully.');
    }).catchError((error) {
      print('Error removing participant: $error');
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
      return const Center(
        child: Text(
          "No participants",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    } else {
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
