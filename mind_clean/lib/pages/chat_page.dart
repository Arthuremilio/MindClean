import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Mind Clean'),
          actions: [
            IconButton(
              onPressed: () => {},
              icon: Icon(Icons.logout),
            )
          ],
        ),
        body: Column(
          children: [Text('MIND CLEAN')],
        ));
  }
}
