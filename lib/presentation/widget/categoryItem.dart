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
       
 List<Category> categories = snapshot.data!.docs.map((doc) {
            return Category.fromJson(doc);
          }).toList();

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((category) {
                return ContainerItem(categories: category);
              }).toList(),
            ),
          );
        }
      },
    );
  }
}

class ContainerItem extends StatelessWidget {
  final Category categories;

  ContainerItem({
    required this.categories,
  });

 
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 80,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
       const   CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue, // You can customize the color
            child: Icon(
              Icons.abc,
              color: Colors.white, // You can customize the color
            ),
          ),
          const SizedBox(height: 5),
          Text(
            categories.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
