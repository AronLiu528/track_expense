import 'package:flutter/material.dart';
import 'package:flutter_03/models/expense.dart';
import 'package:flutter_03/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]), //lesson .120
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },//lesson .120
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
