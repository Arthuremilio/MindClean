import 'package:flutter/material.dart';
import 'package:mind_clean/components/chat_balloon.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  final List<ChatBalloon> _messages = [
    ChatBalloon(
      message: 'Texto da mensagem do sistema',
      isUserMessage: false,
    ),
    ChatBalloon(
      message: 'Texto da mensagem do usuário',
      isUserMessage: true,
    ),
  ];
  // Método para enviar uma imagem selecionada da galeria
  Future<void> _sendImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    _handlePickedFile(pickedFile);
  }

  // Método para tirar uma foto com a câmera
  Future<void> _sendImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    _handlePickedFile(pickedFile);
  }

  // Lida com o arquivo selecionado ou capturado
  Future<void> _handlePickedFile(XFile? pickedFile) async {
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      if (_image != null) {
        String docId = 'id_do_documento'; // Substitua pelo ID real do documento

        await FirebaseFirestore.instance
            .collection('messages')
            .doc(docId)
            .update({
          "image": _image!.path,
        });

        String responseText = 'Texto da resposta do servidor';

        setState(() {
          _messages.insert(0, ChatBalloon(image: _image, isUserMessage: true));
          _messages.insert(
              0, ChatBalloon(message: responseText, isUserMessage: false));
          _image = null; // Reseta a imagem após enviar
        });
      }
    }
  }

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
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (ctx, index) {
                // Retorna cada ChatBalloon diretamente da lista
                return _messages[index];
              },
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
                  onPressed: _sendImageFromGallery,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
                FloatingActionButton(
                  onPressed: _sendImageFromCamera,
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
