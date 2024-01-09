import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evenmt_sportif/model/evenement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListParticipantPage extends StatefulWidget {
  final Evenements eventModel;

  const ListParticipantPage({Key? key, required this.eventModel})
      : super(key: key);

  @override
  State<ListParticipantPage> createState() => _ListParticipantPageState();
}

class _ListParticipantPageState extends State<ListParticipantPage> {
  late List<String> participantEmails = []; 

 late User? user;

  Future<void> initializeUser() async {
    user = FirebaseAuth.instance.currentUser;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    participantEmails = [];
    initializeUser();

    _retrieveParticipantEmails();
  }
 void _acceptparticipant(String participantEmail) async {
  if (widget.eventModel.nbrpartiactul >= widget.eventModel.maxParticipant) {
   print('Event is already full. Cannot accept more participants.');
   const snackBar = SnackBar(
      content: Text(
        'Event is already full. Cannot accept more participants.',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
     _retrieveParticipantEmails();
  }else{


  DocumentReference eventRef = FirebaseFirestore.instance
      .collection('événements')
      .doc(widget.eventModel.id);

  // Add the participant's email to the list of accepted participants
  await eventRef.update({
    'participants': FieldValue.arrayUnion([user?.uid]),
    'nbrpartiactul': FieldValue.increment(1),
  });
  await FirebaseFirestore.instance
      .collection('listattentEvent')
      .where('eventId', isEqualTo: widget.eventModel.id)
      .where('emailapplicantUser', isEqualTo: participantEmail)
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
    snapshot.docs.forEach((DocumentSnapshot<Map<String, dynamic>> doc) {
      doc.reference.delete();
    });
  });
  }
  const snackBar = SnackBar(
      content: Text(
        'Participant add successfully.',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  _retrieveParticipantEmails();

}
  void _refuseparticipe(String participantEmail)async{
    setState(() {
      participantEmails.remove(participantEmail);
    });
     await FirebaseFirestore.instance
      .collection('listattentEvent')
      .where('eventId', isEqualTo: widget.eventModel.id)
      .where('emailapplicantUser', isEqualTo: participantEmail)
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
    snapshot.docs.forEach((DocumentSnapshot<Map<String, dynamic>> doc) {
      doc.reference.delete();
    });
  });

  }

  void _retrieveParticipantEmails() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('listattentEvent')
        .where('eventId', isEqualTo: widget.eventModel.id)
        .get();

    List<String> emails = querySnapshot.docs
        .map((doc) => doc['emailapplicantUser'] as String)
        .toList();

    setState(() {
      participantEmails = emails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm participants"),
        backgroundColor: const Color(0xFF5569FE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _participantCount(),
            const SizedBox(height: 20),
            _participantList(),
          ],
        ),
      ),
    );
  }

  Widget _participantCount() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Max Participants: ${widget.eventModel.maxParticipant}"),
          Text("Current Participants: ${widget.eventModel.nbrpartiactul}"),
        ],
      );

 Widget _participantList() {
  if (participantEmails.isEmpty) {
    return  const Center(
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
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text((index + 1).toString()),
            ),
            title: Text(participantEmails[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon:const Icon(Icons.check, color: Colors.green),
                  onPressed: () {
                    _acceptparticipant(participantEmails[index]);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                   
                    _refuseparticipe(participantEmails[index]);
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
