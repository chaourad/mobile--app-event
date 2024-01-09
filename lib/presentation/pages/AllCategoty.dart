import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evenmt_sportif/presentation/pages/filtreEvent.dart';
import 'package:flutter/material.dart';

class AllCategory extends StatelessWidget {
  const AllCategory({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Category"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Category').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: List.generate(
                  snapshot.data!.docs.length,
                  (index) => CardCategory(
                    title: snapshot.data!.docs[index]['name'] as String,
                    index: index + 1,
                  ),
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class CardCategory extends StatelessWidget {
  final String title;
  final int index;

  CardCategory({required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: GestureDetector(
        onTap: () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  FiltreEvent(typeEvnId:title)),
    );
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(index.toString()),
          ),
          title: Text(title),
        ),
      ),
    );
  }
}
