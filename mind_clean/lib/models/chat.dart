import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../components/chat_balloon.dart';

class ChatProvider with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  final List<ChatBalloon> _messages = [];

  List<ChatBalloon> get messages => _messages;

  Future<void> getMessages() async {
    _messages.clear();
    try {
      final response = await http.get(
        Uri.parse(
            'https://mind-clean-default-rtdb.firebaseio.com/historyChat.json'),
      );

      if (response.body == 'null' || response.statusCode != 200) return;

      final Map<String, dynamic> data = jsonDecode(response.body);

      data.forEach((key, value) {
        if (value['image'] != null) {
          final imageBytes = base64Decode(value['image']);
          _messages.insert(
            0,
            ChatBalloon(
              image: Image.memory(imageBytes),
              isUserMessage: value['isUserMessage'] ?? true,
            ),
          );
        } else if (value['Message'] != null) {
          _messages.insert(
            0,
            ChatBalloon(
              message: value['Message'],
              isUserMessage: value['isUserMessage'] ?? false,
            ),
          );
        }
      });

      notifyListeners();
    } catch (error) {
      print("Erro ao obter mensagens: $error");
    }
  }

  Future<void> sendImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    await _processImageAndSend(pickedFile);
  }

  Future<void> sendImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    await _processImageAndSend(pickedFile);
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
        _messages.insert(
          0,
          ChatBalloon(
              image: Image.file(File(pickedFile.path)), isUserMessage: true),
        );
        notifyListeners();
      } else {
        print('Erro ao enviar a imagem: ${response.statusCode}');
      }
    } catch (error) {
      print("Erro ao enviar a imagem: $error");
    }
  }

  Future<void> _sendDescriptionImage(String description) async {
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
        _messages.insert(
          0,
          ChatBalloon(message: description, isUserMessage: false),
        );
        notifyListeners();
      } else {
        print('Erro ao enviar a imagem: ${response.statusCode}');
      }
    } catch (error) {
      print("Erro ao enviar a imagem: $error");
    }
  }

  Future<void> _processImageAndSend(XFile? pickedFile) async {
    if (pickedFile == null) return;

    try {
      final bytes = await pickedFile.readAsBytes();
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: 'AIzaSyCovP6pBChBYfg4KYHw5rPDAMUqqnd7VlU',
      );
      final prompt =
          "Descreva de maneira resumida se existe uma pessoa na imagem";
      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart('image/jpeg', bytes),
        ])
      ];
      final response = await model.generateContent(content);
      await _sendImage(pickedFile);
      await _sendDescriptionImage(response.text ?? '');
    } catch (error) {
      print("Erro no processamento da imagem e descrição: $error");
    }
  }
}
