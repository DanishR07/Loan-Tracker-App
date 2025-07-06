import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'loan_item.dart';

class HiveService {
  static const String boxName = 'loanBox';
  late Box<LoanItem> _loanBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(LoanItemAdapter());
    _loanBox = await Hive.openBox<LoanItem>(boxName);
  }

  List<LoanItem> getLoans() => _loanBox.values.toList();

  Stream<BoxEvent> watch() => _loanBox.watch();

  void addOrUpdateLoan(LoanItem loan) {
    if (loan.isInBox) {
      loan.save(); // Updates the existing loan
    } else {
      _loanBox.add(loan); // Adds a new loan
    }
  }

  int sumLoans() {
    int total = 0;
    for (var loan in _loanBox.values) {
      total += loan.amount;
    }
    return total;
  }
  void deleteLoan(LoanItem loan) {
    loan.delete();
  }
}
