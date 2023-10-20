import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatDetail extends StatefulWidget {
  final String frienduid;
  final String friendName;

  ChatDetail({Key? key, required this.frienduid, required this.friendName})
      : super(key: key);

  @override
  _ChatDetailState createState() => _ChatDetailState(frienduid, friendName);
}

class _ChatDetailState extends State<ChatDetail> {
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final String frienduid;
  final String friendName;
  String? chatDocId; // Make chatDocId nullable
  var _textController = new TextEditingController();
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  _ChatDetailState(
      this.frienduid, this.friendName); // Properly initialize variables

  void sendMessage(String msg) {
    if (msg == '') return;
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'msg': msg
    }).then((value) {
      _textController.text = '';
    });
  }

  @override
  void initState() {
    super.initState();
    print('frend uid :' + frienduid);
    print('user uid :' + currentUserId);
    chats
        .where('users', isEqualTo: {frienduid: null, currentUserId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            chatDocId = querySnapshot.docs.single.id;
          } else {
            chats.add({
              'users': {
                currentUserId: null,
                frienduid: null
              } // Use null without quotes
            }).then((value) {
              setState(() {
                chatDocId =
                    value.id; // Update the chatDocId with the new document's ID
              });
            });
          }
        })
        .catchError((error) {
          print(error);
        });
  }

  bool isSender(String friend) {
    return friend == currentUserId;
  }

  Alignment getAlignment(friend) {
    if (friend == currentUserId) {
      return Alignment.topRight;
    }
    return Alignment.topLeft;
  }

  @override
  Widget build(BuildContext context) {
    // Implement your chat UI here
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
            //var data = snapshot.data!;
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                previousPageTitle: "Back",
                middle: Text(friendName),
                trailing: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: Icon(CupertinoIcons.phone)),
              ),
              child: SafeArea(
                  child: Column(
                children: [
                  Expanded(
                      child: ListView(
                          reverse: true,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            //var data = document.data()!;
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: ChatBubble(
                                clipper: ChatBubbleClipper6(
                                    nipSize: 0,
                                    radius: 0,
                                    type: BubbleType.receiverBubble),
                                alignment: getAlignment(data['uid'].toString()),
                                margin: EdgeInsets.only(top: 20),
                                backGroundColor:
                                    isSender(data['uid'].toString())
                                        ? Color(0xFF08C187)
                                        : Color(0xffE7E7ED),
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.7,
                                  ),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(data['msg'],
                                            style: TextStyle(
                                                color: isSender(
                                                        data['uid'].toString())
                                                    ? Colors.white
                                                    : Colors.black),
                                            maxLines: 100,
                                            overflow: TextOverflow.ellipsis)
                                      ],
                                    )
                                  ]),
                                ),
                              ),
                            );
                          }).toList())),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: CupertinoTextField(
                        controller: _textController,
                      )),
                      CupertinoButton(
                          child: Icon(Icons.send_sharp),
                          onPressed: (() => sendMessage(_textController.text)))
                    ],
                  )
                ],
              )),
            );
          }
          return Container();
        });
  }
}
