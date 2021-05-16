import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  final Function newTx;
/*
CREATED BY BISWARUP BHATTACHARJEE
EMAIL    : bbiswa471@gmail.com
PHONE NO : 6290272740
*/
  NewTransaction(this.newTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titlecontroller=TextEditingController();
  DateTime sumbitdate;
  final amountcontroller=TextEditingController();


  void submitData(){
    final enteredTitle=titlecontroller.text;
    final enteredAmount=double.parse(amountcontroller.text);
    if(enteredTitle.isEmpty|| enteredAmount<=0 || sumbitdate==null){
       return;
    }
    widget.newTx(
       enteredTitle,enteredAmount,sumbitdate
    );
    Navigator.of(context).pop();
  }

void presentDatePicker() {
  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now()).then((pickeddate){
    if(pickeddate==null)
      {
        return;
      }
    setState(() {
      sumbitdate=pickeddate;
    });

  });

}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Card(
        elevation: 5,
        child:Container(
            padding:EdgeInsets.only(
              top:10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom+10
            ),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titlecontroller,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountcontroller,
                  keyboardType: TextInputType.number,
                  onSubmitted: (__)=>submitData(),
                  maxLength: 6,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                   child:Text(sumbitdate==null ? "No Date Choosen" : "Picked Date : ${DateFormat.yMd().format(sumbitdate)}"),
                    ),
                    FlatButton(
                      child: Text("Choose Date"),
                      textColor: Theme.of(context).primaryColor,
                        onPressed:presentDatePicker ,
                    )
                  ],
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  child: Text("ADD TRANSACTION",
                  ),
                  onPressed: submitData,
                )
              ],
            )
        )
    ));
  }
}
