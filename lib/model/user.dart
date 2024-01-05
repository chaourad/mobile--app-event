import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  String image;
  String email;

  User(
      {required this.id,
      required this.email,
      required this.image,
      required this.name});

  factory User.fromJson(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return User(
      id: doc.id,
      email: data['email'] as String? ?? '',
      image: data['image'] as String? ?? '',
      name: data['name'] as String? ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, "email": email, "image": image};
  }
}
