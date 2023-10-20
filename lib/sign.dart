import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yoo_katale/auth.dart';
import 'package:yoo_katale/auth/expertsignup.dart';
import 'package:yoo_katale/auth/usersignup.dart';
import 'package:yoo_katale/screens/newhomescreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;
  bool isRegisteringAsExpert = false;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> _loginUser(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
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
          content: Text('Login failed. Check your email and password.'),
          backgroundColor: Colors.red, // Added color for emphasis
        ),
      );
    }
  }

  Widget _title() {
    return Column(
      children: [
        Image.asset(
          alignment: Alignment.center,
          'assets/Login.png', // Replace with your image file path
          height: 300,
        ),
        Text(
          'Welcome back. \n Log into your account\n',
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
        fillColor: const Color.fromARGB(255, 248, 247, 247), // Grey input field
      ),
    );
  }

  Widget _errorMessage() {
    return Text(
      errorMessage == "" ? "" : 'Oops! $errorMessage',
      style: TextStyle(
        color: Colors.red,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () {
        final email = _controllerEmail.text;
        final password = _controllerPassword.text;
        _loginUser(email, password, context);
      },
      child: Text(
        'Login',
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

  Widget _registrationButtons() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserRegistrationPage()));
              isRegisteringAsExpert = false;
            });
          },
          child: Text('Register as User', style: TextStyle(color: Colors.grey)),
          style: ElevatedButton.styleFrom(primary: Colors.white),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     setState(() {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => ExpertRegistrationPage()));
        //       isRegisteringAsExpert = true;
        //     });
        //   },
        //   child:
        //       Text('Register as Expert', style: TextStyle(color: Colors.grey)),
        //   style: ElevatedButton.styleFrom(primary: Colors.white),
        // ),
      ],
    );
  }

  void _register() {
    if (isRegisteringAsExpert) {
      // Handle expert registration
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ExpertRegistrationPage()));
    } else {
      // Navigate to your existing user registration page
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const UserRegistrationPage()));
    }
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
                      SizedBox(height: 20),
                      _registrationButtons(),
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
