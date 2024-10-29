
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    
    DateTime atual = DateTime.now();
    String dataFormatada = "${atual.day.toString().padLeft(2, '0')}/${atual.month.toString().padLeft(2, '0')}/${atual.year}";

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ListTile(
          title: Center(
            child: Text( dataFormatada),
          ),
        ),
        ListTile(
          leading: Icon(Icons.task),
          title: Text("Tarefa 1"),
          subtitle: Text("Completar o relatório semanal"),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.pushNamed(context, '/tarefas'); 
          },
        ),
        ListTile(
          leading: Icon(Icons.task),
          title: Text("Tarefa 2"),
          subtitle: Text("Reunião com o time de desenvolvimento"),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
          
          },
        ),
      ],
    );
  }
}
