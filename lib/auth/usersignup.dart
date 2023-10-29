import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yoo_katale/auth/auth.dart';
import 'package:yoo_katale/auth/verification/OTP.dart';
import 'package:yoo_katale/screens/homescreen.dart';

class UserRegistrationPage extends StatefulWidget {
  const UserRegistrationPage({Key? key}) : super(key: key);

  @override
  _UserRegistrationPageState createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
  String? errorMessage = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  //final TextEditingController nameController = TextEditingController();
    
  Future<void> registerUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 300, // Adjusted height for larger logo
          child: Image.asset(
            'assets/signup.png', // Replace with your image file path
          ),
        ),
        Text(
          'User Registration',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue, // Adjusted color for emphasis
          ),
        ),
        Text(
          'Create your account to get started.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Color.fromARGB(255, 248, 247, 247), // Grey input field
      ),
    );
  }

  Widget _errorMessage() {
    return Text(
      errorMessage == "" ? "" : 'Error: $errorMessage',
      style: TextStyle(
        color: Colors.red,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () async {
        await registerUserWithEmailAndPassword();
        User? user = _auth.currentUser;
        print("=====================user is registered===========");
        print(user);

String? documentName;
final UserId = FirebaseAuth.instance.currentUser?.uid;
if (user != null) {
  // Check if the user has an email
  if (user.email != null && user.email!.isNotEmpty) {
    // Use the user's email as the document name
    documentName = user.email;
    print("=====================user has an email :==========="+user.email.toString());
  } else if (user.phoneNumber != null && user.phoneNumber!.isNotEmpty) {
    // Use the user's phone number as the document name
    print("=====================user has phone number :==========="+user.phoneNumber.toString());
    documentName = user.phoneNumber;
  }
}

if (documentName != null) {
  print("=====================user document is created :===========");
  await _firestore.collection('Experts').doc(documentName).set({
    'name': '',
    'email': user?.email,
    'phoneNumber': user!.phoneNumber,
    'profilePictureUrl': '',
    'Specialization': '',
    'Institution': '',
    'uid': UserId,
    'TypeOfUser':'user'
  });
}

 try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      // If login is successful, navigate to the home page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      // Handle authentication error (e.g., incorrect email or password)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed. Check your email and password.'),
          backgroundColor: Colors.red, // Added color for emphasis
        ),
      );
    }

      },
      child: Text(
        'Register',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white, // White text color
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, // Blue button background
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _title(),
                      _entryField('Email', _controllerEmail),
                      SizedBox(height: 20),
                      _entryField('Password', _controllerPassword),
                      SizedBox(height: 10),
                      _errorMessage(),
                      SizedBox(height: 20),
              //         TextFormField(
              //   controller: nameController,
              //   decoration: InputDecoration(
              //     hintText: 'Enter your name',
              //   ),
              // ),
                      _submitButton(),
                      ElevatedButton(
              onPressed: () {
                // Navigate to the next page when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PhoneOTPVerification()),
                );
              },
              child: Text("Register using Phone Number instead"),
            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
