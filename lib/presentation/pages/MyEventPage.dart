import 'package:evenmt_sportif/model/evenement.dart';
import 'package:evenmt_sportif/presentation/widget/card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyEventPage extends StatefulWidget {
  const MyEventPage({Key? key}) : super(key: key);

  @override
  State<MyEventPage> createState() => _MyEventPageState();
}

class _MyEventPageState extends State<MyEventPage> {
  late User? user;

  @override
  void initState() {
    super.initState();
    initializeUser();
  }

  Future<void> initializeUser() async {
    user = FirebaseAuth.instance.currentUser;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Events"),
        backgroundColor: const Color(0xFF5569FE),
      ),
      body: Column(
        children: [
          Text(user?.uid ?? 'No user'),
          _buildEventSection("My Events", "createdByMe", user?.uid),
           _buildEventSec("Created Events", "createdBy", user?.uid),
        ],
      ),
    );
  }

  Widget _buildEventSection(String title, String collection, String? userId) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200, // Adjust the height based on your design
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('événements')
                .where('userId', isEqualTo: userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading events'));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                print(snapshot.data!.docs.length);
                return const Center(child: Text('No events available'));
              } else {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var eventModel = Evenements.fromJson(
                    snapshot.data!.docs[index],
                  );

                  return CardMyEvent(
                    eventModel: eventModel,
                    showNotificationButton: eventModel.hasNotification,
                  );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }}
//
   Widget _buildEventSec(String title, String collection, String? userId) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 200, // Adjust the height based on your design
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('événements')
              .where('participants', arrayContains: userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading events'));
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              print(snapshot.data!.docs.length);
              return const Center(child: Text('No events available'));
            } else {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                     return CardSp(eventModel:  Evenements.fromJson(
                    snapshot.data!.docs[index],),);
                    
                },
              );
            }
          },
        ),
      ),
    ],
  );
}


 
