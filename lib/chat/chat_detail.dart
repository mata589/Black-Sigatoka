// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// class ChatDetail extends StatefulWidget {
//   var frienduid;

//   var friendName;

//   ChatDetail({super.key, required this.frienduid, required this.friendName});

//   @override
//   State<ChatDetail> createState() => _ChatDetailState();
// }

// class _ChatDetailState extends State<ChatDetail> {
//   CollectionReference chats = FirebaseFirestore.instance.collection('chats');
//   late final String frienduid;
//   late final String friendName;
//   var chatDocId;
//   final currentUserId = FirebaseAuth.instance.currentUser!.uid;
//   void initState() {
//     super.initState();
//     chats
//         .where('users', isEqualTo: {frienduid: null, currentUserId: null})
//         .limit(1)
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//           if (querySnapshot.docs.isNotEmpty) {
//             chatDocId = querySnapshot.docs.single.id;
//           } else {
//             chats.add({
//               'users': {currentUserId: null, frienduid: null}
//             }).then((value) => {chatDocId = value});
//           }
//         })
//         .catchError((error) {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
