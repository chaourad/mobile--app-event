
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evenmt_sportif/presentation/widget/StackParticipant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:evenmt_sportif/model/evenement.dart';
import 'package:share/share.dart';

class EventDetailsPage extends StatelessWidget {
  final Evenements eventModel;


  
  Future<String?> getCurrentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }
void applyForEvent() {
  getCurrentUserId().then((userId) {
    if (userId != null) {
      // Fetch additional user information from Firebase Authentication
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String email = user.email ?? '';

        // Create a new document in the 'listattentEvent' collection
        FirebaseFirestore.instance.collection('listattentEvent').add({
          'eventId': eventModel.id,
          'applicantUserId': userId,
          'emailapplicantUser': email,
          'eventCreatorUserId': eventModel.userId,
        }).then((_) {
          // If the addition is successful, show a confirmation message
          print('Application submitted successfully!');
        }).catchError((error) {
          // Handle errors, e.g., user not authenticated or Firestore error
          print('Error submitting application. Please try again.');
        });
      } else {
        print('User not authenticated. Please log in.');
      }
    } else {
      print('User not authenticated. Please log in.');
    }
  });
}





  const EventDetailsPage({required this.eventModel, Key? key}) : super(key: key);
 void _shareEvent(BuildContext context) {
    final String text = 'Check out this event: ${eventModel.name}, happening at ${eventModel.lieu} on ${eventModel.createdat}!';
    Share.share(text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
          backgroundColor: const Color(0xFF5569FE),
             actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              //share event
              _shareEvent(context);
            },
          ),
        ],
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
              _buildDescription(eventModel),
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

  Widget _buildDescription(Evenements eventModel) => Container(
        margin: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventModel.name,
              style:const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const  Icon(Icons.add_location_alt_outlined),
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
             const SizedBox(height: 10,),
           const   StackParticipant(
                  width: 25,
                  height: 25,
                  fontSize: 12,
                  positionText: 95,
                ),
                             const SizedBox(height: 20,),

            const  Text("Regles :", style:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(
              height: 100,
              child: Text( eventModel.regle)),
            SizedBox(
              width: 350,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5569FE),
          foregroundColor: Colors.white, 
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
        onPressed: (){
applyForEvent();        }, child:const Text("Apply now") ))
          
          ],
        ),
      );
     
}
