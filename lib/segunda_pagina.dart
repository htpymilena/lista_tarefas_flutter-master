import 'package:flutter/material.dart';

class SegundaPagina extends StatelessWidget {
  const SegundaPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Segunda Página"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Bem-vindo à segunda página do projeto!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}