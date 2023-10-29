import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatDetail extends StatefulWidget {
  final String frienduid;
  final String friendName;

  ChatDetail({Key? key, required this.frienduid, required this.friendName})
      : super(key: key);

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getChatDocId(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text('Loading')),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text('Error')),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          final chatDocId = snapshot.data;
          return _ChatDetail(
            frienduid: widget.frienduid,
            friendName: widget.friendName,
            chatDocId: chatDocId!,
          );
        }
      },
    );
  }

  Future<String> _getChatDocId() async {
    final chats = FirebaseFirestore.instance.collection('chats');
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    final querySnapshot = await chats
        .where('users',
            isEqualTo: {widget.frienduid: null, currentUserId: null})
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.single.id;
    } else {
      final newDoc = await chats.add({
        'users': {
          currentUserId: null,
          widget.frienduid: null,
        }
      });
      return newDoc.id;
    }
  }
}

class _ChatDetail extends StatelessWidget {
  final String frienduid;
  final String friendName;
  final String chatDocId;

  _ChatDetail({
    required this.frienduid,
    required this.friendName,
    required this.chatDocId,
  });
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  var _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(friendName), // Add the title to the app bar
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // First icon in a white circular avatar
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              // Second icon with an image
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('your_profile_picture_url'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildChatMessages(chatDocId),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildChatMessages(String chatDocId) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("chats")
          .doc(chatDocId)
          .collection('messages')
          .orderBy('createdOn', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Something went wrong"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text("Loading"),
          );
        }

        if (snapshot.hasData) {
          return ListView(
            reverse: true,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: ChatBubble(
                  clipper: ChatBubbleClipper6(
                    nipSize: 5,
                    radius: 15,
                    type: BubbleType.receiverBubble,
                  ),
                  alignment: getAlignment(data['uid'].toString()),
                  margin: EdgeInsets.only(top: 20),
                  backGroundColor: isSender(data['uid'].toString())
                      ? Color.fromARGB(255, 20, 18, 18)
                      : Color.fromARGB(255, 84, 87, 88),
                  child: IntrinsicWidth(
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                data['msg'],
                                style: TextStyle(
                                  color: isSender(data['uid'].toString())
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildMessageInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Container(
        //   padding: EdgeInsets.all(8.0),
        //   decoration: BoxDecoration(
        //     color: Colors.blue,
        //     shape: BoxShape.circle,
        //   ),
        //   child: Icon(
        //     Icons.message,
        //     color: Colors.grey,
        //   ),
        // ),
        SizedBox(width: 12.0),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Write',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        // Expanded(
        //   child: CupertinoTextField(
        //     controller: _textController,
        //   ),
        // ),
        CupertinoButton(
          child: Icon(Icons.send_sharp),
          onPressed: () {sendMessage(_textController.text);
          print('================================');
          print(_textController.text);
          print('================================');
          } 
          // ignore: avoid_print
          
        ),
        SizedBox(width: 8.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 12.0),
      ],
    );
  }

  bool isSender(String friend) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return friend == currentUserId;
  }

  Alignment getAlignment(String friend) {
    if (isSender(friend)) {
      return Alignment.topRight;
    }
    return Alignment.topLeft;
  }

  void sendMessage(String msg) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    if (msg == '') return;
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'msg': msg
    }).then((value) {
      _textController.text = '';
    });
  }
}










// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_chat_bubble/chat_bubble.dart';

// class ChatDetail extends StatefulWidget {
//   final String frienduid;
//   final String friendName;

//   ChatDetail({Key? key, required this.frienduid, required this.friendName})
//       : super(key: key);

//   @override
//   _ChatDetailState createState() => _ChatDetailState(frienduid, friendName);
// }

// class _ChatDetailState extends State<ChatDetail> {
//   CollectionReference chats = FirebaseFirestore.instance.collection('chats');
//   final String frienduid;
//   final String friendName;
//   String? chatDocId; // Make chatDocId nullable
//   var _textController = new TextEditingController();
//   final currentUserId = FirebaseAuth.instance.currentUser!.uid;

//   _ChatDetailState(
//       this.frienduid, this.friendName); // Properly initialize variables

//   void sendMessage(String msg) {
//     if (msg == '') return;
//     chats.doc(chatDocId).collection('messages').add({
//       'createdOn': FieldValue.serverTimestamp(),
//       'uid': currentUserId,
//       'msg': msg
//     }).then((value) {
//       _textController.text = '';
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     print('Init invoked');
//     print('frend uid :' + frienduid);
//     print('user uid :' + currentUserId);
//     chats
//         .where('users', isEqualTo: {frienduid: null, currentUserId: null})
//         .limit(1)
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//           if (querySnapshot.docs.isNotEmpty) {
//             chatDocId = querySnapshot.docs.single.id;
//           } else {
//             chats.add({
//               'users': {
//                 currentUserId: null,
//                 frienduid: null
//               } // Use null without quotes
//             }).then((value) {
//               setState(() {
//                 chatDocId =
//                     value.id; // Update the chatDocId with the new document's ID
//               });
//             });
//           }
//         })
//         .catchError((error) {
//           print(error);
//         });
//     print("=============================================");
//     print('Document Id:');
//     print(chatDocId);
//     print("=============================================");
//   }

//   bool isSender(String friend) {
//     return friend == currentUserId;
//   }

//   Alignment getAlignment(friend) {
//     if (friend == currentUserId) {
//       return Alignment.topRight;
//     }
//     return Alignment.topLeft;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Implement your chat UI here
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection("chats")
//             .doc(chatDocId)
//             .collection('messages')
//             .orderBy('createdOn', descending: true)
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Text("Something went wrong"),
//             );
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: Text("Loading"),
//             );
//           }

//           if (snapshot.hasData) {
//             return CupertinoPageScaffold(
//               navigationBar: CupertinoNavigationBar(
//                 previousPageTitle: "Back",
//                 middle: Text(friendName),
//                 trailing: CupertinoButton(
//                     padding: EdgeInsets.zero,
//                     onPressed: () {},
//                     child: Icon(CupertinoIcons.phone)),
//               ),
//               child: SafeArea(
//                   child: Column(
//                 children: [
//                   Expanded(
//                       child: ListView(
//                           reverse: true,
//                           children: snapshot.data!.docs
//                               .map((DocumentSnapshot document) {
//                             Map<String, dynamic> data =
//                                 document.data() as Map<String, dynamic>;
//                             //var data = document.data()!;
//                             print(
//                                 "========================================================");
//                             print("data is fetched:");
//                             print(
//                                 "========================================================");
//                             return Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 8.0),
//                               child: ChatBubble(
//                                 clipper: ChatBubbleClipper6(
//                                     nipSize: 0,
//                                     radius: 0,
//                                     type: BubbleType.receiverBubble),
//                                 alignment: getAlignment(data['uid'].toString()),
//                                 margin: EdgeInsets.only(top: 20),
//                                 backGroundColor:
//                                     isSender(data['uid'].toString())
//                                         ? Color(0xFF08C187)
//                                         : Color(0xffE7E7ED),
//                                 child: Container(
//                                   constraints: BoxConstraints(
//                                     maxWidth:
//                                         MediaQuery.of(context).size.width * 0.7,
//                                   ),
//                                   child: Column(children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         Text(data['msg'],
//                                             style: TextStyle(
//                                                 color: isSender(
//                                                         data['uid'].toString())
//                                                     ? Colors.white
//                                                     : Colors.black),
//                                             maxLines: 100,
//                                             overflow: TextOverflow.ellipsis)
//                                       ],
//                                     )
//                                   ]),
//                                 ),
//                               ),
//                             );
//                           }).toList())),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                           child: CupertinoTextField(
//                         controller: _textController,
//                       )),
//                       CupertinoButton(
//                           child: Icon(Icons.send_sharp),
//                           onPressed: (() => sendMessage(_textController.text)))
//                     ],
//                   )
//                 ],
//               )),
//             );
//           }
//           return Container();
//         });
//   }
// }
