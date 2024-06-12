import 'package:flutter/material.dart'; //Android style
import 'package:flutter/cupertino.dart'; //ios style
//import 'package:flutter/widgets.dart';
import 'dart:io'; //for Platform

import 'package:flutter_03/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  //接_addExpenseList Function，Lesson .118

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // var _enteredTitle = '';
  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }//儲存user輸入，方法一，lesson .108

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.food;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  //dispose同initState，屬StatefulWidget生命週期的一部分
  //只有State類可實作'dispose'方法，因此需使用StatefulWidget
  //lesson .109

  DateTime? _selectedDate; //最初不會有值，用 => ?

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }
  //lesson .113
  //async & await，lesson .114

  void _showDialog() {
    //偵測設備運行平台
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text('Invalid Input'),
                content: const Text(
                    'Please make sure a valid Title, Amount ,Date and Category was entered....'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx); //與AlertDialog連接
                    },
                    child: const Text('Okay!'),
                  ),
                ],
              ));
    } else {
      showDialog(
        //lesson .117
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid Title, Amount ,Date and Category was entered....'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx); //與AlertDialog連接
              },
              child: const Text('Okay!'),
            ),
          ],
        ),
      );
    }
  } //lesson .141

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    //double.tryParse('Hello')=>null，double.tryParse('3.14')=>3.14
    final amountIsInvalid = //導出T or F
        enteredAmount == null || enteredAmount <= 0;
    // &&=and，兩者皆需符合，||=or，兩者只需符合其中一項
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog(); //lesson .141
      return; //每當在一個Function中返回時，需確保沒有任何代碼被執行
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount, //已在55列解析為int，不使用_amountController <= 為String型態
        date: _selectedDate!, //! => 告訴Dart不是null
        category: _selectedCategory,
      ),
    ); //lesson .118
    Navigator.pop(context); //lesson .119
  } //lesson .116

  @override
  Widget build(BuildContext context) {
    final keyboardSpace =
        MediaQuery.of(context).viewInsets.bottom; //偵測設備尺寸設置，方法一，lesson .138

    return LayoutBuilder(builder: (ctx, constraints) {
      // print(constraints.maxHeight);
      // print(constraints.maxWidth);
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600) //List中的特殊if用法，無{}，lesson .140
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          //onChanged: _saveTitleInput,//儲存user輸入，方法一，lesson .108
                          controller: _titleController, //lesson .109
                          maxLength: 50, //可輸入的最高字符數量
                          decoration: const InputDecoration(
                            label: Text('Title'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true), //自改
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ), //Practice，lesson .110
                      ),
                    ],
                  )
                else //List中的特殊if用法，無{}，lesson .140
                  TextField(
                    //onChanged: _saveTitleInput,//儲存user輸入，方法一，lesson .108
                    controller: _titleController, //lesson .109
                    maxLength: 50, //可輸入的最高字符數量
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                  ), //lesson .107
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory, //顯示選擇的項目
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(), //轉大寫
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        }, //lesson .115
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'Selected Date'
                                  : formatter.format(_selectedDate!),
                            ), //三元運算子，! => 告知flutter不會是空值，前面已檢查過，lesson .114
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true), //自改
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ), //Practice，lesson .110
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'Selected Date'
                                  : formatter.format(_selectedDate!),
                            ), //三元運算子，! => 告知flutter不會是空值，前面已檢查過，lesson .114
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _submitExpenseData();
                          //print(_titleController.text);
                          //print(_amountController.text);
                        },
                        child: const Text('Save Expense'),
                      ), 
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory, //顯示選擇的項目
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(), //轉大寫
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        }, //lesson .115
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _submitExpenseData();
                          //print(_titleController.text);
                          //print(_amountController.text);
                        },
                        child: const Text('Save Expense'),
                      ), //lesson .108
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
