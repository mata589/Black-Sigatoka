import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yoo_katale/screens/homescreen.dart';

class PhoneOTPVerification extends StatefulWidget {
  const PhoneOTPVerification({Key? key}) : super(key: key);

  @override
  State<PhoneOTPVerification> createState() => _PhoneOTPVerificationState();
}

class _PhoneOTPVerificationState extends State<PhoneOTPVerification> {
  TextEditingController phoneNumber = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController otp = TextEditingController();
  bool visible = false;
  String verificationId = "";

  List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    phoneNumber.dispose();
    otpControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/otp.png', width: 300, height: 300),
              SizedBox(height: 20),
              inputTextField("756131020", phoneNumber, context),
              visible
                  ? OTPGrid(context: context, otpControllers: otpControllers)
                  : SizedBox(),
              !visible ? SendOTPButton("Send OTP") : SubmitOTPButton("Submit"),
            ],
          ),
        ),
      ),
    );
  }

  Widget SendOTPButton(String text) => ElevatedButton(
        onPressed: () async {
          setState(() {
            visible = !visible;
          });
          await sendOTP(phoneNumber.text);
        },
        child: Text(text),
      );

Widget SubmitOTPButton(String text) => ElevatedButton(
  child: Text(text),
  onPressed: () async {
    try {
      UserCredential userCredential = await authenticate(verificationId, otp.text);
      User? user = userCredential.user;
      
      if (user != null) {
        // Authentication is successful, and user is available
        print("User is registered: ${user.uid}");
        String? documentName;
        String? UserId;

        if (user.email != null && user.email!.isNotEmpty) {
          documentName = user.email;
        } else if (user.phoneNumber != null && user.phoneNumber!.isNotEmpty) {
          documentName = user.phoneNumber;
        }

        if (documentName != null) {
          print("User document is created");
          await _firestore.collection('Experts').doc(documentName).set({
            'name': '',
            'email': user.email ?? '',
            'phoneNumber': user.phoneNumber ?? '',
            'profilePictureUrl': '',
            'Specialization': '',
            'Institution': '',
            'uid': user.uid,
            'TypeOfUser': 'user',
          });
        }
        
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (e) {
      print("Authentication failed: $e");
    }
  },
);


  Future<void> sendOTP(String phoneNumber) async {
     final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) {
      printMessage("Auto retrieval successful");
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      printMessage("Auto retrieval failed: $e");
    };

    final PhoneCodeSent codeSent = (String verificationId, int? resendToken) {
      printMessage("OTP Sent");
      setState(() {
        this.verificationId = verificationId;
      });
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      printMessage("Auto retrieval timed out");
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+256$phoneNumber',
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      timeout: const Duration(seconds: 60),
    );
  }

  Future authenticate(String verificationId, String otp) async {
     try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      printMessage("Authentication Successful");
      Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
    } catch (e) {
      printMessage("Authentication Failed: $e");
    }
  }
 void printMessage(String msg) {
    debugPrint(msg);
  }

  Widget inputTextField(
    String labelText,
    TextEditingController textEditingController,
    BuildContext context,
  ) =>
      Padding(
        padding: EdgeInsets.all(10.00),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: TextField(
            obscureText: labelText == "OTP",
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: labelText,
              hintStyle: TextStyle(color: Colors.blue),
              filled: true,
              fillColor: Colors.blue[100],
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(5.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(5.5),
              ),
            ),
            // Set autofocus for the phone number field
            autofocus: labelText == "756131020",
          ),
        ),
      );
}

class OTPGrid extends StatelessWidget {
  final List<TextEditingController> otpControllers;
  final BuildContext context;

  OTPGrid({required this.context, required this.otpControllers});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        6,
        (index) => Container(
          width: 50,
          child: TextField(
            controller: otpControllers[index],
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                FocusScope.of(context).nextFocus();
              }
            },
            // Set autofocus for the first text field
            autofocus: index == 0,
          ),
        ),
      ),
    );
  }
}
