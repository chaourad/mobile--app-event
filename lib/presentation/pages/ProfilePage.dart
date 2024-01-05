import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController urlimage = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  late User? user;
  late String username = "";
  XFile? _image;

  File? file;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    fetchUSername();
  }

  void fetchUSername() async {
    try {
      if (user != null) {
        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(user!.uid).get();

        if (userDoc.exists && userDoc.data() != null) {
          setState(() {
            username = userDoc['username'] ?? '';
          });
        }
      }
    } catch (e) {
      print('Erreur lors de la récupération du nom d\'utilisateur : $e');
    }
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context,
          'login'); // Rediriger vers la page de connexion après la déconnexion
    } catch (e) {
      print('Erreur lors de la déconnexion : $e');
    }
  }

  Future<void> _pickImage() async {
  try {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      file = File(image!.path);
      urlimage.text = _image?.path ?? '';
    });

    await _uploadFile(); // Appeler la fonction pour télécharger le fichier après avoir choisi une nouvelle image
  } catch (e) {
    print('Error picking image: $e');
    // Gérez l'erreur (affichez un message, etc.)
  }
}

Future<void> _uploadFile() async {
  try {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child("profile/${DateTime.now().millisecondsSinceEpoch}.jpg");

    TaskSnapshot taskSnapshot =
        await storageReference.putFile(File(_image!.path));

    String photoUrl = await taskSnapshot.ref.getDownloadURL();

    Map<String, dynamic> data = {
      "image": photoUrl,
      'created_at': FieldValue.serverTimestamp()
    };

    await firestore.collection('users').doc(user!.uid).update(data);
  } catch (e) {
    print("Error during file upload: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(85, 105, 254, 1.0),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.white54,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    _pickImage();
                  },
                  child: CircleAvatar(
                    maxRadius: 65,
                    backgroundImage: _image != null
    ? FileImage(file!)
    : AssetImage("assets/6195145.jpg") as ImageProvider<Object>,

                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  username.isNotEmpty ? username : "Guest User",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 26),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("@peakyBlinders")],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Master manipulator, deal-maker and\n                   entrepreneur",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              child: Expanded(
                child: ListView(
                  children: [
                    Card(
                      color: Colors.white70,
                      margin: const EdgeInsets.only(
                          left: 35, right: 35, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: const ListTile(
                        leading: Icon(
                          Icons.privacy_tip_sharp,
                          color: Colors.black54,
                        ),
                        title: Text(
                          'Settings',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Colors.white70,
                      margin: const EdgeInsets.only(
                          left: 35, right: 35, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: const ListTile(
                        leading: Icon(
                          Icons.add_reaction_sharp,
                          color: Colors.black54,
                        ),
                        title: Text(
                          'Invite a Friend',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        _signOut();
                      },
                      child: Card(
                        color: Colors.white70,
                        margin: const EdgeInsets.only(
                            left: 35, right: 35, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: const ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: Colors.black54,
                          ),
                          title: Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_outlined),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
