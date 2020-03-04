import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNew;
  NewTransaction(this.addNew);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amtController = TextEditingController();
  DateTime selectedDate;

  void addFunction() {
    String enteredInput = titleController.text;
    double enteredAmt = double.parse(amtController.text);
    print(enteredAmt);
    if (enteredAmt <= 0 ||
        enteredAmt.toString().isEmpty ||
        enteredInput.isEmpty ||
        selectedDate == null) {
      Fluttertoast.showToast(
          msg: "A valid input is expected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    Fluttertoast.showToast(
        msg: "Transaction Added",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);

    widget.addNew(
      enteredInput,
      enteredAmt,
      selectedDate,
    );

    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(2019),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
      addFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    final focus = FocusNode();

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                textCapitalization: TextCapitalization.sentences,
                onSubmitted: (v) {
                  FocusScope.of(context).requestFocus(focus);
                },
              ),
              TextField(
                focusNode: focus,
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amtController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => presentDatePicker(),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(selectedDate == null
                        ? 'No Date Chosen'
                        : 'Picked Date: ${DateFormat.yMd().format(selectedDate)}'),
                  ),
                  FlatButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: presentDatePicker,
                  ),
                ],
              ),
              RaisedButton(
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                child: Text('Add Transaction'),
                onPressed: addFunction,
              )
            ],
          ),
        ),
      ),
    );
  }
}
