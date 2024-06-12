import 'package:flutter/material.dart';

import 'package:flutter_03/widgets/expenses_list/expenses_list.dart';
import 'package:flutter_03/models/expense.dart';
import 'package:flutter_03/widgets/expenses_list/new_expense.dart';
import 'package:flutter_03/Widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ), //lesson .100
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverLay() {
    showModalBottomSheet(
      useSafeArea: true,//lesson .139
      isScrollControlled: true, //lesson .119
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpenseList),
    ); //ctx 屬於 showModalBottomSheet 使用，與context不同
  } //lesson .106

  void _addExpenseList(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  } //加入列表，lesson .118

  void _removeExpenseList(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context)
        .clearSnackBars(); //當有下一條訊息出現，立即清除上一條訊息，lesson .121
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    ); //顯示刪除訊息/取消刪除並加回列表 //lesson .121
  } //從列表中刪除，lesson .120

  @override
  Widget build(BuildContext context) {
    Widget mainContent =
        const Center(child: Text('No expenses found.Start adding some!'));

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpenseList,
      );
    } //lesson .121

    //print(MediaQuery.of(context).size.width);輸出當前設備寬度，lesson .136
    //print(MediaQuery.of(context).size.height);輸出當前設備高度，lesson .136
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverLay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registeredExpenses),
                ), //chart被設置為infinity width，
                Expanded(
                  child: mainContent,
                ),
              ],
            ), //設備直向橫向不同UI排列，lesson .136
    );
  }
}
