import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evenmt_sportif/model/category.dart';
import 'package:flutter/material.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Category').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error loading categories');
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No categories available');
        } else {
          return const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              
            ),
          );
        }
      },
    );
  }
}

class ContainerItem extends StatelessWidget {
  final Category category;

  ContainerItem({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
     
          const SizedBox(height: 5),
          Text(
            category.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}