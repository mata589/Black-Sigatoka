import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yoo_katale/chat/chat_detail.dart';

import 'package:yoo_katale/model/user.dart';

class ExpertListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expert List'),
      ),
      body: ExpertList(),
    );
  }
}

class ExpertList extends StatefulWidget {
  @override
  State<ExpertList> createState() => _ExpertListState();
}

class _ExpertListState extends State<ExpertList> {
  void callChatDetailScreen(String name, String uid) {}
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Experts').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final experts = snapshot.data!.docs;

        return ListView.builder(
          itemCount: experts.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data =
                experts[index].data() as Map<String, dynamic>;
            var name = data['name'];
            var specialization = data['Specialization'];
            var institution = data['Institution'];
            var profilePictureUrl = data['profilePictureUrl'];
            var uid = 1;

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(profilePictureUrl),
              ),
              title: Text(name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(specialization),
                  Text(institution),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  // Pass the current expert to the UserItem widget
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (_) => ChatDetail(
                  //           friendName: name,
                  //           frienduid: uid,
                  //         )));
                },
                child: Text('Chat'),
              ),
            );
          },
        );
        ;
      },
    );
  }
}
