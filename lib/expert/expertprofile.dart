import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
  final UserId = FirebaseAuth.instance.currentUser!.uid;
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
        const SnackBar(content: Text('No paper has been selected')),
      );
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
          title: Text('Submission successful'),
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.contacts,
              color: Colors.orange,
            ),
            Text(
              'EXPERTS',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: screenWidth * 0.1),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.black,
                    size: screenHeight * 0.1,
                  ),
                  Text(
                    'ADD PROFILE PHOTO',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenHeight * 0.025,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              ElevatedButton(
                onPressed: () {
                  _pickImage();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  minimumSize: MaterialStateProperty.all(
                    Size(screenWidth * 0.6, screenHeight * 0.08),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: screenHeight * 0.05,
                    ),
                    Icon(
                      Icons.file_copy,
                      color: Colors.white,
                      size: screenHeight * 0.05,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                'ADD CV AND DOCUMENTS',
                style: TextStyle(fontSize: screenHeight * 0.025),
              ),
              SizedBox(height: screenHeight * 0.03),
              ElevatedButton(
                onPressed: () {
                  pickpapers();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  minimumSize: MaterialStateProperty.all(
                    Size(screenWidth * 0.6, screenHeight * 0.08),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.insert_drive_file,
                      color: Colors.white,
                      size: screenHeight * 0.05,
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Text(
                      'Choose Files',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.025,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextFormField(
                controller: specializationController,
                decoration: InputDecoration(
                  hintText: 'Enter your field of specialization',
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextFormField(
                controller: institutionController,
                decoration: InputDecoration(
                  hintText: 'Enter your institution (optional)',
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              ElevatedButton(
                onPressed: () async {
                  User? user = _auth.currentUser;
                  await _firestore.collection('Experts').doc(user!.email).set({
                    'name': nameController.text,
                    'email': user.email,
                    'phoneNumber': user.phoneNumber,
                    'profilePictureUrl': pictureUrl,
                    'Specialization': specializationController.text,
                    'Institution': institutionController.text,
                    'uid': UserId ,
                    'TypeOfUser':'Expert'
                  });

                  await _showConfirmationDialog();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                  minimumSize: MaterialStateProperty.all(
                    Size(screenWidth * 0.6, screenHeight * 0.08),
                  ),
                ),
                child: Text(
                  'VERIFY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenHeight * 0.025,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
