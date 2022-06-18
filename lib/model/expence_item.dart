
import 'package:hive/hive.dart';

part 'expence_item.g.dart';

@HiveType(typeId: 0)
class ExpenceItem extends HiveObject {
  @HiveField(0)
  final String category;
  @HiveField(1)
  final DateTime date;
  @HiveField(2)
  final double amout;

  ExpenceItem(this.category, this.date, this.amout);
}