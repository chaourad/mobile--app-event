import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evenmt_sportif/model/evenement.dart';
import 'package:evenmt_sportif/presentation/widget/CardEventThisMonth.dart';
import 'package:flutter/material.dart';

class AllEvent extends StatelessWidget {
  const AllEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All event"),
        backgroundColor: const Color(0xFF5569FE),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:10 ),
        child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('événements').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: List.generate(
                  snapshot.data!.docs.length,
                  (index) => CardEventThisMonth(
                    eventModel: Evenements.fromJson(
                      snapshot.data!.docs[index],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
        ),
      ),
    );
  }
}