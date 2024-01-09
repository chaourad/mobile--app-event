import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evenmt_sportif/model/evenement.dart';
import 'package:evenmt_sportif/presentation/widget/CardEventThisMonth.dart';
import 'package:flutter/material.dart';

class AllEventPopular extends StatelessWidget {
  const AllEventPopular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Only popular event"),
                backgroundColor: const Color(0xFF5569FE),

      ),
      body: SingleChildScrollView(
              scrollDirection: Axis.vertical,

        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('événements').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Evenements> events = snapshot.data!.docs.map((doc) {
                return Evenements.fromJson(doc);
              }).toList();
        
              events.sort((a, b) => b.nbrpartiactul.compareTo(a.nbrpartiactul));
        
              List<Evenements> top5Events = events.take(5).toList();
        
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: top5Events.map((event) {
                    return CardEventThisMonth(
                      eventModel: event,
                    );
                  }).toList(),
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
