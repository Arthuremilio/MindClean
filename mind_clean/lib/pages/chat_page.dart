import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mind_clean/components/chat_balloon.dart';
import 'package:mind_clean/models/chat.dart';
import 'package:mind_clean/utils/app_routes.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mind Clean', style: Theme.of(context).textTheme.bodyLarge),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.AUTH),
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16.0),
              itemCount: chatProvider.messages.length,
              itemBuilder: (ctx, index) {
                return chatProvider.messages[index];
              },
            ),
          ),
          Divider(color: Colors.white),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'Gallery',
                  onPressed: chatProvider.sendImageFromGallery,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
                FloatingActionButton(
                  heroTag: 'Camera',
                  onPressed: chatProvider.sendImageFromCamera,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: const Icon(Icons.camera_alt, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
