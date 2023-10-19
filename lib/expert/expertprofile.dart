import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class ExpertsPage extends StatefulWidget {
  @override
  _ExpertsPageState createState() => _ExpertsPageState();
}

class _ExpertsPageState extends State<ExpertsPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController institutionController = TextEditingController();
  File? profilePicture;
  PlatformFile? cvDocument;
  FilePickerResult? result;
  var file;
  var storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String pictureUrl;
  late String CV;

  pickpapers() async {
    result = (await FilePicker.platform.pickFiles(
      withReadStream: true,
      allowMultiple: true,
    ))!;
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No paper has been selected')));
    }

    file = result!.files.first;
    final path = result!.files.single.path!;
    final fileName = result!.files.single.name;

    uploadfile(path, fileName);
  }

  Future<void> uploadfile(String filepath, String fileName) async {
    File file = File(filepath);

    try {
      var snapshot = await storage
          .ref()
          .child('cv_documents/' + fileName)
          .putFile(file)
          .whenComplete(() {
        print('==============file uploaded successful=============');
      });
      String url = await (snapshot).ref.getDownloadURL();

      print(url);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _uploadimage() async {
    if (profilePicture != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_pictures/${DateTime.now().toIso8601String()}');
      final uploadTask = storageRef.putFile(profilePicture!);
      final storageResult = await uploadTask.whenComplete(() => null);
      pictureUrl = await storageResult.ref.getDownloadURL();
      print('Uploaded picture URL: $pictureUrl');
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        profilePicture = File(pickedImage.path);
      });

      _uploadimage();
    }
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Submition successful'),
          content: Text('Proceed?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pop(); // Handle returning to the home screen
              },
              child: Text('Return to Home'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Resubmit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expert Registration"),
        actions: [
          IconButton(
            icon: Icon(Icons.contacts),
            onPressed: () {
              // Handle contacts action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.contacts, color: Colors.blue),
                Text("ADD PROFILE PHOTO"),
              ],
            ),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.camera_alt),
              label: Text("Choose Image"),
            ),
            Text("ADD CV AND DOCUMENTS"),
            ElevatedButton.icon(
              onPressed: pickpapers,
              icon: Icon(Icons.file_copy),
              label: Text("Choose pdf"),
            ),
            Text(
              'Name:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Field of Specialization:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: specializationController,
              decoration: InputDecoration(
                hintText: 'Enter your field of specialization',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Institution:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: institutionController,
              decoration: InputDecoration(
                hintText: 'Enter your institution (optional)',
              ),
            ),
            SizedBox(height: 32),
            TextButton(
              onPressed: () async {
                User? user = _auth.currentUser;
                if (user != null) {
                  await _firestore.collection('Experts').doc(user.email).set({
                    'name': nameController.text,
                    'email': user.email,
                    'profilePictureUrl': pictureUrl,
                    'Specialization': specializationController.text,
                    'Institution': institutionController.text
                  });
                  await _showConfirmationDialog(); // Show the confirmation dialog
                }
              },
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
