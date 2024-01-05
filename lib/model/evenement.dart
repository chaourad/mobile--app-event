import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evenmt_sportif/model/user.dart';

class Evenements {
  String id;
  String name;
  String lieu;
  int maxParticipant;
  String regle;
  String typeEvnId;
  String userId;
  Timestamp dateDebut;
  Timestamp created_at;
  String image;
  List<User> participants;

  Evenements(
      {required this.id,
      required this.name,
      required this.lieu,
      required this.dateDebut,
      required this.maxParticipant,
      required this.regle,
      required this.typeEvnId,
      required this.userId,
      required this.participants,
      required this.created_at,
      required this.image});

  factory Evenements.fromJson(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Evenements(
        id: doc.id,
        name: data['name'] as String? ?? '',
        lieu: data['lieu'] as String? ?? '',
        dateDebut: data['dateDebut'] as Timestamp? ?? Timestamp.now(),
        maxParticipant: data['maxParticipant'] as int? ?? 0,
        regle: data['regle'] as String? ?? '',
        typeEvnId: data['typeEvnId'] as String? ?? '',
        image: data['image'] as String? ?? '',
        participants: data['participants'] != null
            ? List<User>.from(data['participants'].map((x) => User.fromJson(x))): [],
            created_at : data['created_at']  as Timestamp? ?? Timestamp.now(),
        userId: data['userId'] as String? ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lieu': lieu,
      'dateDebut': dateDebut,
      'maxParticipant': maxParticipant,
      'regle': regle,
      'typeEvnId': typeEvnId,
      'userId': userId,
      'participants': participants.map((user) => user.toJson()).toList(),
      'image': image,
      'created_at': created_at
    };
  }

}

