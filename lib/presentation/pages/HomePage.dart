import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evenmt_sportif/model/evenement.dart';
import 'package:evenmt_sportif/presentation/widget/CardEventThisMonth.dart';
import 'package:evenmt_sportif/presentation/widget/CardPopularEvent.dart';
import 'package:evenmt_sportif/presentation/widget/categoryItem.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final instancefire =
      FirebaseFirestore.instance.collection('événements').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            /*  SizedBox(
              height: 100,
              width: 1000,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  color: Color.fromRGBO(85, 105, 254, 1.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Hello, Emma 👋🏻",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(85, 105, 254, 1.0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // category
                    ],
                  ),
                ),
              ),
            ),
*/
            const SizedBox(height: 54),
            const TitleList(titre: "Category of sport"),
            const CategoryListView(),
            const SizedBox(height: 24),
            const TitleList(titre: "Popular Event"),
            const SizedBox(height: 16),
            _cardhoe(),
            const SizedBox(height: 24),
            const TitleList(titre: "Event this Month"),
            const SizedBox(height: 16),
            _cardevent(),
          ],
        ),
      ),
    );
  }
}

_cardhoe() => StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('événements').snapshots(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      // Convertir les documents en une liste d'événements
      List<Evenements> events = snapshot.data!.docs.map((doc) {
        return Evenements.fromJson(doc);
      }).toList();

      // Trier les événements en fonction du nombre de participants
      events.sort((a, b) => b.nbrpartiactul.compareTo(a.nbrpartiactul));

      // Prendre les 5 premiers événements
      List<Evenements> top5Events = events.take(5).toList();

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: top5Events.map((event) {
            return CardPopularEvent(
              eventModel: event,
            );
          }).toList(),
        ),
      );
    } else {
      return const CircularProgressIndicator();
    }
  },
);

_cardevent() => StreamBuilder<QuerySnapshot>(
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
    );

class TitleList extends StatelessWidget {
  final String titre;

  const TitleList({Key? key, required this.titre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titre,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const Text(
            "View All",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
