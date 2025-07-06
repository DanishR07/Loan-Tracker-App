import 'package:flutter/material.dart';

import 'loan_item.dart';

class LoanWidget extends StatelessWidget {
  LoanItem loan;
  final Function(LoanItem) onEdit;
  final Function(LoanItem) onDelete;
  final Function(LoanItem) onToggleStatus;


  LoanWidget(this.loan,{required this.onEdit,required this.onDelete,required this.onToggleStatus});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: ListTile(
        title: Text(
          loan.personName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Rs. ${loan.amount} ",
          style: TextStyle(color: Colors.green),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
          IconButton(onPressed: ()=>onEdit(loan), icon:Icon(Icons.edit)),
            IconButton(onPressed:()=> onDelete(loan), icon:Icon(Icons.delete)),


            GestureDetector(
              onTap: () => onToggleStatus(loan),
              child: Card(
                color: loan.isReturned?Colors.blue:Colors.redAccent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),
                  child: Text(loan.isReturned?"Returned":"Pending",style: TextStyle(color:loan.isReturned?Colors.green:Colors.amber),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
