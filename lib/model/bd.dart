import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Bd {
  static final Bd instance = Bd._init();
  static Database? _database;

  Bd._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('tarefas.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const tarefaTable = '''
    CREATE TABLE tarefas (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      descricao TEXT NOT NULL,
      data TEXT NOT NULL
    )
    ''';

    await db.execute(tarefaTable);
  }

  Future<void> fazerTarefa(String descricao, String data) async {
    final db = await instance.database;

    final tarefa = {
      'descricao': descricao,
      'data': data,
    };

    await db.insert('tarefas', tarefa);
  }

  Future<List<Map<String, dynamic>>> getTarefas() async {
    final db = await instance.database;
    return await db.query('tarefas');
  }

  Future<void> updateTarefa(int id, String descricao, String data) async {
    final db = await instance.database;

    final tarefa = {
      'descricao': descricao,
      'data': data,
    };

    await db.update(
      'tarefas',
      tarefa,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteTarefa(int id) async {
    final db = await instance.database;
    await db.delete(
      'tarefas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
