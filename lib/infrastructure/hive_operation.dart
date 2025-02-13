import 'package:hive/hive.dart';
import 'package:jothilabproject/infrastructure/hive_productmode.dart';

class HiveOperations {
 static addToCart(ProductHiveModel product) async {
    try {
      final dbData = Hive.box<ProductHiveModel>("cart");
      print(" Data $product");
      print("addToCart Data ${dbData.values}");
      final id = await dbData.add(product);
      final entry = dbData.get(id);
      product.id = id;
      if (entry != null) {
        await dbData.put(id, product);
      }
      print("dbData - $dbData");
    } catch (e) {
      print("addToCart Exception ${e.toString()}");
    }
  }

  static List<ProductHiveModel> getDatas() {
    final dbData = Hive.box<ProductHiveModel>("cart");

    for (var q in dbData.values) {
      print("Get Data ${q.title}");
    }
    return List.from(dbData.values);
  }

  static Future removeFromCart(int id) async {
    print("ID Delete $id");
    final dbData = Hive.box<ProductHiveModel>("cart");
    dbData.delete(id);
  }
}
