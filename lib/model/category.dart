import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String id;
  String name;
  String icon;

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Category.fromJson(DocumentSnapshot doc) {
    Map json = doc.data() as Map; 
    return Category(
        id: doc.id,
      name: json['name'] ?? '',
      icon: json['icon'] ?? '', 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
    };
  }
}