import 'package:flutter/material.dart';
import 'dart:io'; // Para trabalhar com arquivos locais de imagem

class ChatBalloon extends StatelessWidget {
  final String? message; // Texto da mensagem
  final Image? image; // Arquivo de imagem (pode ser null se for texto)
  final bool isUserMessage;

  const ChatBalloon({
    Key? key,
    this.message,
    this.image,
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
                child: image != null
                    ? image
                    : Text(
                        message ?? '',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
              ),
            ),
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('lib/assets/img/user_logo.png'),
            ),
          ] else ...[
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('lib/assets/img/mind_clean_logo.png'),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 8.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: message != null
                    ? Text(
                        message!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    : image,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
