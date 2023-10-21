import 'package:flutter/material.dart';

void main() => runApp(ChatScreen1());

class ChatScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('Friend Name'), // Add the title to the app bar
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
        body: ChatScreenBody(),
      ),
    );
  }
}

class ChatScreenBody extends StatefulWidget {
  @override
  _ChatScreenBodyState createState() => _ChatScreenBodyState();
}

class _ChatScreenBodyState extends State<ChatScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Messages
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              // Received message
              MessageBubble(
                message: 'Hello there! How are you?',
                isSent: false,
              ),
              // Sent message
              MessageBubble(
                message: 'I\'m doing great. Thanks!',
                isSent: true,
              ),
              // ... Add more messages here
            ],
          ),
        ),
        // Message input field with padding
        Container(
          margin: EdgeInsets.only(bottom: 16.0), // Add margin at the bottom
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // Left button with message icon
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.message,
                    color: Colors.grey,
                  ),
                ),
                // Message input text field
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Write',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    width:
                        8.0), // Add space between the text field and the following widget
                // Right button with camera icon
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isSent;

  MessageBubble({required this.message, required this.isSent});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSent ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: isSent ? Colors.black : Colors.blue,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isSent ? Colors.white : Colors.white,
          ),
        ),
      ),
    );
  }
}
