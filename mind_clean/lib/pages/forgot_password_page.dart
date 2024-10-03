import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ), // Ícone de seta para voltar
          onPressed: () {
            Navigator.of(context).pop(); // Retorna à tela anterior
          },
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  child: Image.asset(
                    'lib/assets/img/mind_clean.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Esqueceu a senha?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: deviceSize.width * 0.45,
                  child: Text(
                    'Informe seu email abaixo para receber a senha',
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Form(
                  child: Container(
                    width: deviceSize.width * 0.90,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: deviceSize.width * 0.80,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Enviar',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
