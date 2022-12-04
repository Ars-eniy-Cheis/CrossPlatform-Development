import 'package:hive/hive.dart';
part 'shopping_model.g.dart';

@HiveType(typeId: 0)
class ShoppingModel extends HiveObject{
  @HiveField(0)
  late var name;
  @HiveField(1)
  late var cost;
  @HiveField(2)
  late var createdDate;


  ShoppingModel(String name, double cost, DateTime createdDate){
      this.name = name;
      this.cost = cost;
      this.createdDate = createdDate;
  }
}