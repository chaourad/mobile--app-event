import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evenmt_sportif/model/category.dart';
import 'package:evenmt_sportif/model/evenement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AjouterEvent extends StatefulWidget {
    final Evenements? eventModel;

  const AjouterEvent({Key? key, this.eventModel}) : super(key: key);

  @override
  State<AjouterEvent> createState() => _AjouterEventState();
}

class _AjouterEventState extends State<AjouterEvent> {
  final ImagePicker _picker = ImagePicker();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lieuController = TextEditingController();
  final TextEditingController maxParticipantController =
      TextEditingController();
  final TextEditingController regleController = TextEditingController();
  final TextEditingController dateInputController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController urlimage = TextEditingController();

  Timestamp selectedTimestamp = Timestamp.now();
  XFile? _image;
  Category? selectedValue;
  List<DropdownMenuItem<Category>> dropdownItems = [];
  File? file;

  Future<String?> getCurrentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        file = File(image!.path);
        urlimage.text = _image?.path ?? '';
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void clearFields() {
    nameController.clear();
    lieuController.clear();
    maxParticipantController.clear();
    regleController.clear();
    urlimage.clear();
    typeController.clear();
    dateInputController.clear();
    setState(() {
      _image = null;
      file = null;
    });
  }

  Future<void> _uploadFile() async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("images/${DateTime.now().millisecondsSinceEpoch}.jpg");

      TaskSnapshot taskSnapshot =
          await storageReference.putFile(File(_image!.path));

      String photoUrl = await taskSnapshot.ref.getDownloadURL();
      String? userId = await getCurrentUserId();
      //print('Current User ID: $userId');

      Map<String, dynamic> data = {
        "lieu": lieuController.text,
        "typeEvnId": selectedValue!.id,
        "regle": regleController.text,
        "userId": userId,
        "dateDebut": selectedTimestamp,
        "maxParticipant": int.parse(maxParticipantController.text),
        "name": nameController.text,
        "image": photoUrl,
        'created_at': FieldValue.serverTimestamp(),
      };

  if (widget.eventModel != null) {
        await FirebaseFirestore.instance
            .collection("événements")
            .doc(widget.eventModel!.id)
            .update(data);
            //envoye des notification 
      } else {
        await FirebaseFirestore.instance.collection("événements").add(data);
      }
      clearFields();
      
    } catch (e) {
      print("Error during file upload: $e");
    }
  }
 @override
  void initState() {
    super.initState();
    type(); 
    if (widget.eventModel != null) {
      populateFields(); 
    }
  }
  void populateFields() {
  nameController.text = widget.eventModel?.name ?? '';
  lieuController.text = widget.eventModel?.lieu ?? '';
  maxParticipantController.text =
  widget.eventModel?.maxParticipant.toString() ?? '';
  regleController.text = widget.eventModel?.regle ?? '';
  dateInputController.text = widget.eventModel?.dateDebut.toDate().toString() ?? '';
  urlimage.text = widget.eventModel?.image ?? '';
}
  Future<void> type() async {
  try {
    QuerySnapshot<Map<String, dynamic>> categoriesSnapshot =
        await FirebaseFirestore.instance.collection('Category').get();

    List<Category> categories = categoriesSnapshot.docs.map((doc) {
      return Category.fromJson(doc);
    }).toList();

    if (categories.length > 0) {
      setState(() {
        dropdownItems = categories
            .map((Category category) {
              return DropdownMenuItem<Category>(
                value: category,
                child: Text(category.name),
              );
            })
            .toList();
      });

      print('Dropdown Items: $dropdownItems');
    } else {
      print('No data available in the "Category" collection.');
    }
  } catch (error) {
    print('Error: $error');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajouter des événements',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(85, 105, 254, 1.0),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 30.0),
            if (_image != null)
              Image.file(
                File(_image!.path),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              )
            else
              const Text('No image selected'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image from Gallery'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: lieuController,
              decoration: InputDecoration(
                labelText: "Lieu",
                prefixIcon: const Icon(Icons.add_location_alt_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: maxParticipantController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Nombre de participant",
                prefixIcon: const Icon(Icons.add),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: dateInputController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.calendar_today),
                labelText: "Enter Date and Time",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDateTime = await showDatePicker(
                  context: context,
                  initialDate: selectedTimestamp.toDate(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2100),
                );

                if (pickedDateTime != null) {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(selectedTimestamp.toDate()),
                  );

                  if (pickedTime != null) {
                    setState(() {
                      selectedTimestamp = Timestamp.fromDate(
                        DateTime(
                          pickedDateTime.year,
                          pickedDateTime.month,
                          pickedDateTime.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        ),
                      );

                      dateInputController.text =
                          selectedTimestamp.toDate().toString();
                    });
                  }
                }
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: regleController,
              minLines: 4,
              maxLines: 8,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: "Entre les règles d'événement",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<Category>(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 114, 114, 114),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 114, 114, 114),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              dropdownColor: Colors.grey.shade100,
              value: selectedValue,
              onChanged: (Category? newValue) {
                setState(() {
                  selectedValue = newValue;
                    print("Selected Category ID: ${selectedValue!.id}");

                });
              },
              items: dropdownItems,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5569FE),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await _uploadFile();
                        //Navigate
                      } catch (e) {
                        print("Error adding activity: $e");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5569FE),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
