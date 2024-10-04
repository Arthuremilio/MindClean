import 'dart:io';
import 'dart:math';
import 'package:mind_clean/components/chat_balloon.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mind_clean/utils/app_routes.dart';
import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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

  Future<void> _sendImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    processImageAndSend(pickedFile);
  }

  Future<void> _sendImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    processImageAndSend(pickedFile);
  }

  Future<void> _sendImage(XFile? pickedFile) async {
    if (pickedFile == null) return;

    try {
      final imageBytes = await pickedFile.readAsBytes();
      final base64Image = base64Encode(imageBytes);

      final response = await http.post(
        Uri.parse(
            'https://mind-clean-default-rtdb.firebaseio.com/historyChat.json'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "image": base64Image,
          "isUserMessage": true,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _messages.insert(
            0,
            ChatBalloon(image: File(pickedFile.path), isUserMessage: true),
          );
        });
      } else {
        print('Erro ao enviar a imagem: ${response.statusCode}');
      }
    } catch (error) {
      print("Erro ao enviar a imagem: $error");
    }
  }

  Future<void> _sendDescriptionImage(String description) async {
    if (description == null) return;

    try {
      final response = await http.post(
        Uri.parse(
            'https://mind-clean-default-rtdb.firebaseio.com/historyChat.json'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "Message": description,
          "isUserMessage": false,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _messages.insert(
            0,
            ChatBalloon(message: description, isUserMessage: false),
          );
        });
      } else {
        print('Erro ao enviar a imagem: ${response.statusCode}');
      }
    } catch (error) {
      print("Erro ao enviar a imagem: $error");
    }
  }

  Future<void> processImageAndSend(XFile? pickedFile) async {
    if (pickedFile == null) return;

    try {
      final bytes = await pickedFile.readAsBytes();
      final String base64Image = base64Encode(bytes);
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: 'AIzaSyCoYXc-vW7x5hSuzYtwhMaJc6llVxfee7Y',
      );
      final prompt =
          "Describe the following image in Brazilian Portuguese: Base64: $base64Image";
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      _sendDescriptionImage(response.text ?? '');
      _sendImage(pickedFile);
    } catch (error) {
      print("Erro no processamento da imagem e descrição: $error");
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
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.AUTH),
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
                return _messages[index];
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
                  onPressed: _sendImageFromGallery,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
                FloatingActionButton(
                  heroTag: 'Camera',
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
