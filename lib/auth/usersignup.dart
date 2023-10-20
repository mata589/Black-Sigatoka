import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yoo_katale/auth.dart';

class UserRegistrationPage extends StatefulWidget {
  const UserRegistrationPage({Key? key}) : super(key: key);

  @override
  _UserRegistrationPageState createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

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
      onPressed: () {
        registerUserWithEmailAndPassword();
      },
      child: Text(
        'Register as User',
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
                      _submitButton(),
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
