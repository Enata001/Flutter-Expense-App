import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  const TransactionList(this.transactions, this.deleteTransaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return transactions.isNotEmpty
        ? ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) => Dismissible(
              key: Key(transactions[index].id),
              background: Container(
                margin: const EdgeInsets.all(10),
                color: Colors.red.shade400,
              ),
              onDismissed: (direction) =>
                  deleteTransaction(transactions[index].id),
              child: Card(
                elevation: 2,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                            '\$${transactions[index].amount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: IconButton(
                      onPressed: () =>
                          deleteTransaction(transactions[index].id),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.brown,
                      )),
                ),
              ),
            ),
          )
        : LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "No Transactions added yet",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.4,
                  width: constraints.maxWidth * 0.4,
                  child: Image.asset(
                    'assets/image/waiting.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            );
          });
  }
}
