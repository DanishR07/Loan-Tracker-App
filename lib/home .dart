import 'package:flutter/material.dart';
import 'add_loan_item.dart';
import 'loan_item.dart';
import 'loan_item_widget.dart';
import 'hive_service.dart';

class HomePage extends StatefulWidget {
  final HiveService hiveService;
  const HomePage({Key? key, required this.hiveService}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<LoanItem> _loans = [];

  @override
  void initState() {
    super.initState();
    _loadLoans();
    widget.hiveService.watch().listen((event) => _loadLoans());
  }

  void _loadLoans() {
    setState(() {
      _loans = widget.hiveService.getLoans();
    });
  }

  int calculateTotalLoan() {
    return _loans.fold(0, (sum, item) => sum + item.amount);
  }

  void _editLoan(LoanItem loan) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddLoanItem(hiveService: widget.hiveService, loanToEdit: loan),
      ),
    );
  }

  void _deleteLoan(LoanItem loan) {
    widget.hiveService.deleteLoan(loan);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Deleted")));
  }

  void _toggleStatus(LoanItem loan) {
    setState(() {
      loan.isReturned = !loan.isReturned;
      widget.hiveService.addOrUpdateLoan(loan);
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = calculateTotalLoan();
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Management", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddLoanItem(hiveService: widget.hiveService),
            ),
          );
        },
        label: Text("Add Person"),
        icon: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _loans.length,
              itemBuilder: (context, index) => LoanWidget(
                _loans[index],
                onEdit: _editLoan,
                onDelete: _deleteLoan,
                onToggleStatus: _toggleStatus,
              ),
            ),
          ),
          Container(
            height: 50,
            color: Colors.amberAccent,
            child: Center(
              child: Text(
                "Total Loan: Rs. $total ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
