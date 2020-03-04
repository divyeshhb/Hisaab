import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              Container(
                child: Text(
                  'No Transactions to Show!',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  './assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : Card(
            margin: EdgeInsets.all(10),
            elevation: 5,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).accentColor,
                      foregroundColor: Colors.white,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\₹${transactions[index].amt.toStringAsFixed(2)}'),
                        ),
                      ),
                    ),
                    title: Container(
                      child: Text(
                        '${transactions[index].title}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].dt),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => deleteTx(transactions[index].id),
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
          );
  }
}
