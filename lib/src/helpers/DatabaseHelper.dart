import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mynul_test/src/models/ProductModel.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;
  DatabaseHelper._instance();

  Future<Database> get db async {
    _database ??= await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'product_db.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        category TEXT,
        price REAL,
        discountPercentage REAL,
        rating REAL,
        stock INTEGER,
        tags TEXT,
        brand TEXT,
        sku TEXT,
        weight INTEGER,
        dimensions TEXT,
        warrantyInformation TEXT,
        shippingInformation TEXT,
        availabilityStatus TEXT,
        reviews TEXT,
        returnPolicy TEXT,
        minimumOrderQuantity INTEGER,
        meta TEXT,
        images TEXT,
        thumbnail TEXT
      )
    ''');
  }

  Future<int> insertProduct(Product product) async {
    final dbClient = await db;
    return await dbClient.insert('products', product.toDatabase());
  }

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final dbClient = await db;
    final maps = await dbClient.query('products');
    return maps;
  }

  Future<int> updateProduct(Product product) async {
    final dbClient = await db;
    return await dbClient.update(
      'products',
      product.toDatabase(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> deleteProduct(int id) async {
    final dbClient = await db;
    return await dbClient.delete('products', where: 'id = ?', whereArgs: [id]);
  }

  Future<Product?> getProductById(int id) async {
    final dbClient = await db;
    final result = await dbClient.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Product.fromDatabase(result.first);
    }
    return null;
  }
}
