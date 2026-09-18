import 'package:flutter/material.dart';
import 'segunda_pagina.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 231, 231, 231),
      ),

      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController tarefaController = TextEditingController();

  List<String> tarefas = []; // Lista para armazenar as tarefas 
  int? indiceEditando;

  void adicionarTarefa() {
    if (tarefaController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Erro na operação"),
            content: Text("Não é possível adicionar uma tarefa vazia!"),
          );
        },
      );
    return;
  }

    setState(() {
      if (indiceEditando == null) {
        tarefas.add(tarefaController.text);
      } else {
        tarefas[indiceEditando!] = tarefaController.text;
        indiceEditando = null;
      }
    });
  
    tarefaController.clear(); // Limpa o campo de texto após adicionar a tarefa
  }

  void removerTarefa(int index) {
    setState(() {
      tarefas.removeAt(index);

      if (indiceEditando == index) {
        indiceEditando = null;
        tarefaController.clear();
      } else if (indiceEditando != null && indiceEditando! > index){
        indiceEditando = indiceEditando! - 1;
      }
    });
  }
    
    void editarTarefa(int index) {
      setState(() {
        indiceEditando = index;
        tarefaController.text = tarefas[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Tarefas',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: tarefaController,
                    decoration: InputDecoration(
                      hintText: 'Digite uma tarefa',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    adicionarTarefa();
                  },
                  child: Text(indiceEditando == null ? 'Adicionar' : 'Salvar'),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Expanded(
              child: ListView.builder(
                itemCount: tarefas.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(tarefas[index]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              editarTarefa(index);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          removerTarefa(index);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
          const SizedBox(height: 12.0,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Ir para outra página'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SegundaPagina(),
                    ),
                  );
                },
             ),
            ),
          ],
        ),
      ),
    );
  }
}