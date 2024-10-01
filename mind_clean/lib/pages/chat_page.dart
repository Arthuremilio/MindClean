import 'package:flutter/material.dart';
import 'package:mind_clean/components/chat_balloon.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mind Clean', style: Theme.of(context).textTheme.bodyLarge),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.all(16.0),
              children: [
                ChatBalloon(
                  message:
                      'There are many programming languages in the market that are used in designing and building websites, various applications and other tasks. All these languages are popular in their place and in the way they are used, and many programmers learn and use them.',
                  isUserMessage: false,
                ),
                ChatBalloon(
                  message: 'User message here!',
                  isUserMessage: true,
                ),
                // Adicione mais mensagens aqui, se necessário
              ],
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
                FloatingActionButton(
                  onPressed: () {},
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
