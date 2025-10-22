import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mynul_test/src/models/PostModel.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('posts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE posts (
        id INTEGER PRIMARY KEY,
        userId INTEGER,
        title TEXT,
        body TEXT
      )
    ''');
  }

  Future<void> savePost(Post post) async {
    final db = await instance.database;
    await db.insert(
      'posts',
      post.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> savePosts(List<Post> posts) async {
    final db = await instance.database;
    final batch = db.batch();

    for (var post in posts) {
      batch.insert(
        'posts',
        post.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<Post>> getPosts() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('posts');

    return List.generate(maps.length, (i) {
      return Post.fromJson(maps[i]);
    });
  }

  Future<Post?> getPost(int id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'posts',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return Post.fromJson(maps.first);
    }
    return null;
  }
}
