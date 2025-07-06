import 'package:hive/hive.dart';
part 'loan_item.g.dart';

@HiveType(typeId: 0)
class LoanItem extends HiveObject {
  @HiveField(0)
  int id = 0;  // Explicitly defining the id field

  @HiveField(1)
  String personName;

  @HiveField(2)
  int amount;

  @HiveField(3)
  bool isReturned;

  LoanItem(this.personName, this.amount, {this.isReturned = false});
}
