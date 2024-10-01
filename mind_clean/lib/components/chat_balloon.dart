import 'package:flutter/material.dart';

class ChatBalloon extends StatelessWidget {
  final String message;
  final bool isUserMessage;

  const ChatBalloon({
    Key? key,
    required this.message,
    required this.isUserMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment:
            isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (isUserMessage) ...[
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 8.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            CircleAvatar(
              radius: 20,
              // backgroundImage: AssetImage(
              //     'assets/images/user_image.png'), // Substitua pelo caminho da imagem do usuário
            ),
          ] else ...[
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                  'lib/assets/img/mind_clean_logo.png'), // Substitua pelo caminho da imagem do usuário
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 8.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
