import 'package:flutter/material.dart';

class TarefaEscolhida extends StatefulWidget {
  const TarefaEscolhida({super.key});

  @override
  State<TarefaEscolhida> createState() => _TarefaEscolhidaState();
}

class _TarefaEscolhidaState extends State<TarefaEscolhida> {
  int _currentIndex = 0; // Índice da aba atual

  final List<Widget> _pages = [
    Center(child: Text('Página Home', style: TextStyle(fontSize: 24))),
    Center(child: Text('Página de Tarefas', style: TextStyle(fontSize: 24))),
    Center(child: Text('Página de Perfil', style: TextStyle(fontSize: 24))),
  ];

  void exibirAlerta(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Atenção'),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _adicionarTarefa(String titulo, String data) async {
    try {
      // await Bd.instance.adicionarTarefa(titulo, data);
      exibirAlerta('Tarefa adicionada com sucesso!');
    } catch (e) {
      exibirAlerta('Erro ao adicionar a tarefa: $e');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[500],
        title: const Text(
          'Tarefas Diárias',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.asset(
              'assets/images/tarefas.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.task),
                  title: Text('Estudar Flutter'),
                ),
                ListTile(
                  leading: Icon(Icons.task),
                  title: Text('Fazer exercícios de cibersegurança'),
                ),
                ListTile(
                  leading: Icon(Icons.task),
                  title: Text('Ler livro de programação'),
                ),
                ListTile(
                  leading: Icon(Icons.task),
                  title: Text('Revisar código do aplicativo de tarefas'),
                ),
                ListTile(
                  leading: Icon(Icons.task),
                  title: Text('Realizar teste final do projeto'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                    onPressed: () {
                      _adicionarTarefa('Nova Tarefa', '2024-10-04');
                    },
                    child: const Text(
                      "Adicionar Tarefa",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 0) {
              Navigator.pushNamed(context, '/');
            } else if (_currentIndex == 1) {
              Navigator.pushNamed(context, '/tarefas');
            } else if (_currentIndex == 2) {
              Navigator.pushNamed(context, '/perfil');
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tarefas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
