import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
/*
CREATED BY BISWARUP BHATTACHARJEE
EMAIL    : bbiswa471@gmail.com
PHONE NO : 6290272740
*/
class TransactionList extends StatelessWidget{
  @override
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions,this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? LayoutBuilder(builder:(ctx,contraints){
          return Column(
      children: <Widget>[
        SizedBox(
          height: contraints.maxHeight*0.05,
        ),
        Container(
          height: contraints.maxHeight*0.20,
        child:AutoSizeText("NO TRANSACTIONS ADDED YET",
        minFontSize: 28,
        maxFontSize: 42,
        style:TextStyle(fontFamily: 'CB'
        )
        )),
        SizedBox(
          height: contraints.maxHeight*0.05,
        ),
        Container(
          height:contraints.maxHeight*0.45,
          child: Image.asset('assets/images/sadface.png',fit:BoxFit.cover),
              
        ),
        SizedBox(
          height:contraints.maxHeight*0.25 ,
        )
      ],
    );
      }) :
      ListView.builder(
        itemBuilder: (ctx,index){
          return Card(
            margin: EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 8,
            ),
            child:ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.purpleAccent,
              foregroundColor: Colors.black,
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: FittedBox(
                  child: AutoSizeText(
                    '₹${transactions[index].amount}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        )
                        ,
                    minFontSize: 2,
                  ),
                ),
              ),
            ),
            title: AutoSizeText(transactions[index].title,
            style: TextStyle(
              fontFamily: 'AS',
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),),
            subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
            trailing: MediaQuery.of(context).size.width>460 ?
                FlatButton.icon(
                  icon: Icon(Icons.delete),
                  color:Theme.of(context).errorColor,
                  label: AutoSizeText('Delete'),
                  onPressed: () => deleteTx(transactions[index].id),
                ):
            IconButton(
              icon: Icon(Icons.delete),
              color:Theme.of(context).errorColor,
              onPressed: () => deleteTx(transactions[index].id),
            ),
          ),);
        },
        itemCount: transactions.length,
      );

}
}
