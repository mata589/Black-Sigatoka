// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:yoo_katale/screens/homescreen.dart';

// class PhoneOTPVerification extends StatefulWidget {
//   const PhoneOTPVerification({Key? key}) : super(key: key);

//   @override
//   State<PhoneOTPVerification> createState() => _PhoneOTPVerificationState();
// }

// class _PhoneOTPVerificationState extends State<PhoneOTPVerification> {
//   TextEditingController phoneNumber = TextEditingController();
//   TextEditingController otp = TextEditingController();
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//       final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//     //final TextEditingController nameController = TextEditingController();

//   bool visible = false;
//   String verificationId = "";

//   @override
//   void dispose() {
//     phoneNumber.dispose();
//     otp.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      appBar: AppBar(
//         title: Text('OTP Verification', style: TextStyle(color: Colors.black)),
//         backgroundColor: Colors.white, // You can set the app bar background color as needed
//       ),
//       body: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset('assets/otp.png', width: 300, height: 300),
//             SizedBox(height: 20),
//               // TextFormField(
//               //   controller: nameController,
//               //   decoration: InputDecoration(
//               //     hintText: 'Enter your name',
//               //   ),
//               // ),
//             inputTextField("756131020", phoneNumber, context),
//             visible ? inputTextField("OTP", otp, context) : SizedBox(),
//             !visible ? SendOTPButton("Send OTP") : SubmitOTPButton("Submit"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget SendOTPButton(String text) => ElevatedButton(
//         onPressed: () async {
//           setState(() {
//             visible = !visible;
//           });
//           await sendOTP(phoneNumber.text);

          
//         },
//         child: Text(text),
//       );

//   Widget SubmitOTPButton(String text) => ElevatedButton(
//     child: Text(text),
//         onPressed: () async {
//   // Assume authenticate is an asynchronous function
//   await authenticate(verificationId, otp.text);
//   print("===========user is registered===========");
//   User? user = _auth.currentUser;
//        //final UserId = FirebaseAuth.instance.currentUser?.uid;
//   String? documentName;
//  var UserId;
//   if (user != null) {
//     FirebaseAuth.instance.authStateChanges().listen((User? user) {
//   if (user != null) {
//     // User is authenticated, you can access UserId here.
//     UserId = user.uid;
//     print('useruid:'+user.uid.toString());
//   }
// });
//     // Check if the user has an email
//     if (user.email != null && user.email!.isNotEmpty) {
//       // Use the user's email as the document name
//       print("================user has an email: ${user.email}");
//       documentName = user.email;
//     } else if (user.phoneNumber != null && user.phoneNumber!.isNotEmpty) {
//       // Use the user's phone number as the document name
//       print("================user has a phone number: ${user.phoneNumber}");
//       documentName = user.phoneNumber;
//     }
//   }

//   if (documentName != null) {
//     print("===========user document is created===========");
//     await _firestore.collection('Experts').doc(documentName).set({
//       'name': '',
//       'email': user?.email,
//       'phoneNumber': user!.phoneNumber,
//       'profilePictureUrl': '',
//       'Specialization': '',
//       'Institution': '',
//       'uid': UserId,
//       'TypeOfUser': 'user',
//     });
//   }
//   Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => HomePage()),
//       );
// }
  
//       );

//   Future<void> sendOTP(String phoneNumber) async {
//     final PhoneVerificationCompleted verificationCompleted =
//         (PhoneAuthCredential credential) {
//       printMessage("Auto retrieval successful");
//     };

//     final PhoneVerificationFailed verificationFailed =
//         (FirebaseAuthException e) {
//       printMessage("Auto retrieval failed: $e");
//     };

//     final PhoneCodeSent codeSent = (String verificationId, int? resendToken) {
//       printMessage("OTP Sent");
//       setState(() {
//         this.verificationId = verificationId;
//       });
//     };

//     final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
//         (String verificationId) {
//       printMessage("Auto retrieval timed out");
//     };

//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: '+256$phoneNumber',
//       verificationCompleted: verificationCompleted,
//       verificationFailed: verificationFailed,
//       codeSent: codeSent,
//       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
//       timeout: const Duration(seconds: 60),
//     );
//   }

//   Future<void> authenticate(String verificationId, String otp) async {
//     try {
//       final credential = PhoneAuthProvider.credential(
//         verificationId: verificationId,
//         smsCode: otp,
//       );

//       final userCredential =
//           await FirebaseAuth.instance.signInWithCredential(credential);
//       printMessage("Authentication Successful");
//       Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => HomePage()),
//                 );
//     } catch (e) {
//       printMessage("Authentication Failed: $e");
//     }
//   }

//   void printMessage(String msg) {
//     debugPrint(msg);
//   }

//   Widget inputTextField(String labelText,
//           TextEditingController textEditingController, BuildContext context) =>
//       Padding(
//         padding: EdgeInsets.all(10.00),
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width / 1.5,
//           child: TextFormField(
//             obscureText: labelText == "OTP",
//             controller: textEditingController,
//             decoration: InputDecoration(
//               hintText: labelText,
//               hintStyle: TextStyle(color: Colors.blue),
//               filled: true,
//               fillColor: Colors.blue[100],
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.transparent),
//                 borderRadius: BorderRadius.circular(5.5),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.transparent),
//                 borderRadius: BorderRadius.circular(5.5),
//               ),
//             ),
//           ),
//         ),
//       );
// }



// try {
//   final UserCredential userCredential = await authenticate(verificationId, otp.text);
//   final User? user = userCredential.user;

//   if (user != null) {
//     print("User is registered: ${user.uid}");
//     // Continue with user registration or other actions
//   } else {
//     print("User is null");
//   }
// } catch (e) {
//   print("Authentication failed: $e");
// }
