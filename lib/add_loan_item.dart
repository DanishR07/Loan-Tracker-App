import 'package:flutter/material.dart';
import 'loan_item.dart';
import 'hive_service.dart';

class AddLoanItem extends StatefulWidget {
  final HiveService hiveService;
  final LoanItem? loanToEdit;

  const AddLoanItem({Key? key, required this.hiveService, this.loanToEdit}) : super(key: key);

  @override
  State<AddLoanItem> createState() => _AddLoanItemState();
}

class _AddLoanItemState extends State<AddLoanItem> {
  late TextEditingController nameController;
  late TextEditingController amountController;
  String? nameError;
  String? amountError;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.loanToEdit?.personName ?? '');
    amountController = TextEditingController(text: widget.loanToEdit?.amount.toString() ?? '');
  }

  void saveLoan() {
    setState(() {
      nameError = null;
      amountError = null;
    });

    String name = nameController.text.trim();
    String amount = amountController.text.trim();

    if (name.isEmpty) {
      setState(() => nameError = "Please fill this field");
      return;
    }
    if (amount.isEmpty) {
      setState(() => amountError = "Please fill this field");
      return;
    }

    LoanItem loan = widget.loanToEdit ?? LoanItem(name, int.parse(amount));
    loan.personName = name;
    loan.amount = int.parse(amount);
    widget.hiveService.addOrUpdateLoan(loan);

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.loanToEdit == null ? "Loan added successfully" : "Loan updated successfully"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.loanToEdit == null ? "Add Loan" : "Update Loan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Person Name",
                hintText: "Enter Name",
                errorText: nameError,
                suffixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: "Loan Amount",
                hintText: "Enter Amount",
                errorText: amountError,
                suffixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveLoan,
              child: Text(widget.loanToEdit == null ? "Save" : "Update"),
            ),
          ],
        ),
      ),
    );
  }
}
