import 'package:expenses/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './models/transactions.dart';
import './widgets/chart.dart';

var global = 2;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hisaab Kitaab',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.green,
        errorColor: Colors.red[400],
        accentColorBrightness: Brightness.dark,
        primaryColorBrightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transactions> userTransactions = [
    Transactions(
      id: '#001',
      title: 'New Clothes',
      amt: 1549,
      dt: DateTime.now(),
    ),
    Transactions(
      id: '#002',
      title: 'Movie',
      amt: 860.00,
      dt: DateTime.now(),
    ),
  ];
  List<Transactions> get recentTx {
    return userTransactions.where((tx) {
      return tx.dt.isAfter(DateTime.now().subtract(
        Duration(
          days: 7,
        ),
      ));
    }).toList();
  }

  void addNewTransaction(String title, double amt, DateTime dt) {
    global++;
    final newTx = Transactions(
      title: title,
      amt: amt,
      dt: dt,
      id: '\#00$global',
    );

    setState(() {
      userTransactions.add(newTx);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void deleteTransaction(String id) {
    setState(() {
      userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Hisaab ₹'),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.height - 
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.2,
                child: ChartWidget(recentTx)),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.8,
              child: TransactionList(userTransactions, deleteTransaction),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}
