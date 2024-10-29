import 'package:atividade_pedido/model/bd.dart';
import 'package:flutter/material.dart';

class Tarefa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TarefaScreen(); 
  }
}

class TarefaScreen extends StatefulWidget {
  @override
  _TarefaScreenState createState() => _TarefaScreenState();
}

class _TarefaScreenState extends State<TarefaScreen> {
  List<Map<String, dynamic>> tarefas = []; 

  @override
  void initState() {
    super.initState();
    _loadTarefas();
  }

  // Carregar tarefas do banco de dados
  Future<void> _loadTarefas() async {
    final tarefaList = await Bd.instance.getTarefas(); 
    setState(() {
      tarefas = tarefaList; 
    });
  }

  
  Future<void> _addTarefa(String titulo, String data) async {
    await Bd.instance.fazerTarefa(titulo, data);
    _loadTarefas(); // Atualiza a lista de tarefas
  }


  Future<void> _updateTarefa(int id, String titulo, String data) async {
    await Bd.instance.updateTarefa(id, titulo, data); 
    _loadTarefas(); 
  }

  
  Future<void> _deleteTarefa(int id) async {
    await Bd.instance.deleteTarefa(id); 
    _loadTarefas(); 
  }


  void _showEditDialog(BuildContext context, int id, String titulo, String data) {
    TextEditingController tituloController = TextEditingController(text: titulo);
    TextEditingController dataController = TextEditingController(text: data);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Atualizar Tarefa"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tituloController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: dataController,
                decoration: InputDecoration(labelText: 'Data (YYYY-MM-DD)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Atualizar"),
              onPressed: () {
                _updateTarefa(id, tituloController.text, dataController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarefas Pendentes"),
      ),
      body: ListView.builder(
        itemCount: tarefas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tarefas[index]['titulo']),
            subtitle: Text('Data: ${tarefas[index]['data']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showEditDialog(
                    context,
                    tarefas[index]['id'],
                    tarefas[index]['titulo'],
                    tarefas[index]['data'],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteTarefa(tarefas[index]['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back), 
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/');
        },
      ),
    );
  }
}
