// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function makeTransaction;
  const NewTransaction(this.makeTransaction, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime? pickedDate;

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (amountController.text.isEmpty ||
        enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        pickedDate == null) {
      return;
    }

    widget.makeTransaction(enteredTitle, enteredAmount, pickedDate);

    Navigator.of(context).pop();
  }

  void _presentDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(const Duration(days: 6)),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        this.pickedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    pickedDate == null
                        ? 'No date chosen'
                        : 'Picked date: ${DateFormat.yMd().format(pickedDate as DateTime)}',
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: _presentDate,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: _submitData,
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Add Transaction',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
