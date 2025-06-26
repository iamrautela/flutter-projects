// FILE: home_page.dart

import 'package:flutter/material.dart';

enum Category { Work, Leisure, Flight, Food }

class Expense {
  String title;
  double amount;
  DateTime date;
  Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });
}

class ExpenseHomePage extends StatefulWidget {
  @override
  _ExpenseHomePageState createState() => _ExpenseHomePageState();
}

class _ExpenseHomePageState extends State<ExpenseHomePage> {
  final List<Expense> _expenses = [];
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category? _selectedCategory;
  DateTime _selectedDate = DateTime.now();

  void _openExpenseDialog({Expense? expense, int? index}) {
    if (expense != null) {
      _titleController.text = expense.title;
      _amountController.text = expense.amount.toString();
      _selectedCategory = expense.category;
      _selectedDate = expense.date;
    } else {
      _titleController.clear();
      _amountController.clear();
      _selectedCategory = null;
      _selectedDate = DateTime.now();
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(expense == null ? 'Add Expense' : 'Edit Expense'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Amount'),
              ),
              DropdownButtonFormField<Category>(
                value: _selectedCategory,
                hint: Text('Select Category'),
                items: Category.values.map((Category category) {
                  return DropdownMenuItem<Category>(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              Row(
                children: [
                  Text('Date: ${_selectedDate.toLocal().toString().split(' ')[0]}'),
                  Spacer(),
                  TextButton(
                    onPressed: () => _pickDate(ctx),
                    child: Text('Pick Date'),
                  ),
                ],
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final title = _titleController.text;
              final amount = double.tryParse(_amountController.text) ?? 0;
              final category = _selectedCategory;

              if (title.isEmpty || amount <= 0 || category == null) return;

              setState(() {
                final newExpense = Expense(
                  title: title,
                  amount: amount,
                  date: _selectedDate,
                  category: category,
                );

                if (expense == null) {
                  _expenses.add(newExpense);
                } else {
                  _expenses[index!] = newExpense;
                }
              });

              Navigator.of(ctx).pop();
            },
            child: Text(expense == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  void _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _deleteExpense(int index) {
    setState(() {
      _expenses.removeAt(index);
    });
  }

  Color _categoryColor(Category category) {
    switch (category) {
      case Category.Work:
        return Colors.blue.shade100;
      case Category.Leisure:
        return Colors.green.shade100;
      case Category.Flight:
        return Colors.orange.shade100;
      case Category.Food:
        return Colors.pink.shade100;
    }
  }

  IconData _categoryIcon(Category category) {
    switch (category) {
      case Category.Work:
        return Icons.work;
      case Category.Leisure:
        return Icons.sports_esports;
      case Category.Flight:
        return Icons.flight;
      case Category.Food:
        return Icons.fastfood;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker with Categories'),
      ),
      body: _expenses.isEmpty
          ? Center(child: Text('No expenses added yet.'))
          : ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (ctx, i) {
                final e = _expenses[i];
                return Card(
                  color: _categoryColor(e.category),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    leading: Icon(_categoryIcon(e.category), size: 30),
                    title: Text(e.title),
                    subtitle: Text(
                      '₹${e.amount.toStringAsFixed(2)} • ${e.date.toLocal().toString().split(' ')[0]} • ${e.category.name}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blueAccent),
                          onPressed: () =>
                              _openExpenseDialog(expense: e, index: i),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => _deleteExpense(i),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openExpenseDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
