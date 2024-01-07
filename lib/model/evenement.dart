import 'package:cloud_firestore/cloud_firestore.dart';

class Evenements {
  String id;
  String name;
  String lieu;
  int maxParticipant;
  String regle;
  String typeEvnId;
  String userId;
  Timestamp dateDebut;
  int nbrpartiactul;
  Timestamp createdat;
    bool hasNotification;
  String image;
  List<String>? participants;

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
      required this.nbrpartiactul,
      required this.createdat,
      required this.hasNotification,
      required this.image});

  factory Evenements.fromJson(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    List<dynamic>? participantsData = data['participants'] as List<dynamic>?;

    List<String>? participants =
        participantsData?.map((participant) => participant as String).toList();

    return Evenements(
        id: doc.id,
        name: data['name'] as String? ?? '',
        lieu: data['lieu'] as String? ?? '',
        dateDebut: data['dateDebut'] as Timestamp? ?? Timestamp.now(),
        maxParticipant: data['maxParticipant'] as int? ?? 0,
        regle: data['regle'] as String? ?? '',
        typeEvnId: data['typeEvnId'] as String? ?? '',
        image: data['image'] as String? ?? '',
        participants: participants,
        hasNotification: data['listattentEvent'] != null &&
          data['listattentEvent'].contains(/* Nouvel élément */),     
         nbrpartiactul: data['nbrpartiactul'] as int? ?? 0,
        createdat: data['created_at'] as Timestamp? ?? Timestamp.now(),
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
      'participants': participants,
      'image': image,
      'nbrpartiactul': nbrpartiactul,
      'created_at': createdat
    };
  }
 
}
