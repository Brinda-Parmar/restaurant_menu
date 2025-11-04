import 'package:path/path.dart';
import 'package:restaurantmenuapp/data/models/cart_item_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService{
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() {
    return _instance;
  }
  DatabaseService._internal();

  Database? _database;

  Future <Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath,'cart.db' );
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart_items(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            price REAL,
            quantity INTEGER,
            image TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertUpdateCartItem(CartItemModel item) async {
    final database = await this.database;

    final existing = await database.query(
      'cart_items',
      where: 'id = ?',
      whereArgs: [item.id],
    );

    if(existing.isEmpty){
      await database.insert(
        'cart_items',
        item.toMap()
      );
    }else{
        await database.update('cart_items', item.toMap(), where: "id = ?", whereArgs: [item.id]);
    }
  }

  Future<void> deleteCartItem(int id) async {
    final database = await this.database;

    await database.delete(
      'cart_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<CartItemModel>> getCartItems() async {
    final database = await this.database;

    final List<Map<String, dynamic>> maps = await database.query('cart_items');

    return maps.map((m) => CartItemModel.fromMap(m)).toList();
  }

  Future<void> clearCart() async {
    final database = await this.database;
    database.delete('cart_items');
  }
}