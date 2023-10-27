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
  TextEditingController otp = TextEditingController();
  bool visible = false;
  String verificationId = "";

  @override
  void dispose() {
    phoneNumber.dispose();
    otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Phone OTP Authentication"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputTextField("756131020", phoneNumber, context),
            visible ? inputTextField("OTP", otp, context) : SizedBox(),
            !visible ? SendOTPButton("Send OTP") : SubmitOTPButton("Submit"),
          ],
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
        onPressed: () => authenticate(verificationId, otp.text),
        child: Text(text),
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

  Future<void> authenticate(String verificationId, String otp) async {
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

  Widget inputTextField(String labelText,
          TextEditingController textEditingController, BuildContext context) =>
      Padding(
        padding: EdgeInsets.all(10.00),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: TextFormField(
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
          ),
        ),
      );
}
