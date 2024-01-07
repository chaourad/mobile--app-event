import 'package:cloud_firestore/cloud_firestore.dart';

class Participant{
  String id;
  String username;
  String image;
  String email;

  Participant(
      {required this.id,
      required this.email,
      required this.image,
      required this.username});

  factory Participant.fromJson(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Participant(
      id: doc.id,
      email: data['email'] as String? ?? '',
      image: data['image'] as String? ?? '',
      username: data['username'] as String? ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, "email": email, "image": image};
  }
}
