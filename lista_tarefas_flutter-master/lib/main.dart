import 'package:flutter/material.dart';

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

  void adicionarTarefa() {
    if (tarefaController.text.isEmpty) {
      // add snackbar
      return;
    }

    setState(() {
      tarefas.add(tarefaController.text);
    });
  
  tarefaController.clear(); // Limpa o campo de texto após adicionar a tarefa

  }
  void removerTarefa(int index){
    setState(() {
      tarefas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
                SizedBox(width: 8.0),
                ElevatedButton(onPressed: () {
                  adicionarTarefa();
                }, 
                child: Text('Adicionar')),
              ],
            ),
            SizedBox(height: 12.0),
            Expanded(
              child: ListView.builder(
                itemCount: tarefas.length,
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      title: Text(tarefas[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          removerTarefa(index);
                        },
                      ),
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
