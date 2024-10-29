import 'package:atividade_pedido/view/menu.dart';
import 'package:atividade_pedido/view/Tarefaescolhida.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
       '/tarefas': (context) => const TarefaEscolhida(),
       '/menu': (context) => const Menu(),
      },
      title: 'Atividade de pedidos',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text('Tarefas'),
        ),
        
        body: const Center(
          child: Menu(),
        ),
      ),
    );
  }
}

