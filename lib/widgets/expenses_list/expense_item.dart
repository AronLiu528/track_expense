import 'package:flutter/material.dart';
import 'package:flutter_03/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(expense.title,style: Theme.of(context).textTheme.titleLarge,),
          const SizedBox(height: 5),
          Row(
            children: [
              //Text(expense.amount.toString()), 簡易的將double型態轉字串
              Text('\$ ${expense.amount.toStringAsFixed(2)}'), //2:修正為顯示小數點第幾位
              const Spacer(),
              Row(
                children: [
                  Icon(categoryIcons[expense.category]),//lesson .104
                  const SizedBox(width: 5),
                  Text(expense.formattedDate),//lesson .104
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
