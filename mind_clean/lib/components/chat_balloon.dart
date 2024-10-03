import 'package:flutter/material.dart';
import 'dart:io'; // Para trabalhar com arquivos locais de imagem

class ChatBalloon extends StatelessWidget {
  final String? message; // Texto da mensagem
  final File? image; // Arquivo de imagem (pode ser null se for texto)
  final bool isUserMessage;

  const ChatBalloon({
    Key? key,
    this.message, // Texto pode ser null se for uma imagem
    this.image, // Imagem pode ser null se for uma mensagem de texto
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
                child: image != null // Verifica se é uma imagem
                    ? Image.file(
                        image!,
                        fit: BoxFit.cover,
                        height:
                            150, // Ajuste a altura da imagem conforme necessário
                      )
                    : Text(
                        message ?? '', // Se não for imagem, exibe o texto
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
              ),
            ),
            CircleAvatar(
              radius: 20,
              // Aqui você pode adicionar uma imagem/avatar do usuário
            ),
          ] else ...[
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                  'lib/assets/img/mind_clean_logo.png'), // Logo da aplicação
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 8.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: message != null // Verifica se é uma mensagem de texto
                    ? Text(
                        message!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    : Image.file(
                        image!,
                        fit: BoxFit.cover,
                        height:
                            150, // Ajuste a altura da imagem conforme necessário
                      ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
