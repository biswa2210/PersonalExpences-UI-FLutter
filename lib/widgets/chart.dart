import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/chart_bars.dart';
class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String,Object>> get gettransactions{
    return List.generate(7, (index) {
      final weekday=DateTime.now().subtract(
          Duration(days:index)
      );
      var totalAmount=0.0;
      for(var i=0;i<recentTransactions.length;i++){
        if(recentTransactions[i].date.day==weekday.day &&
            recentTransactions[i].date.month==weekday.month &&
            recentTransactions[i].date.year==weekday.year){
          totalAmount+=recentTransactions[i].amount;
        }
      }
      return {
        'day':DateFormat.E().format(weekday).substring(0,1),
        'amount':totalAmount};
    }).reversed.toList();
  }
  double get maxSpending{
    return gettransactions.fold(0.0, (sum, item) {
      return sum+item['amount'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child:Container(
        padding: EdgeInsets.all(10),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: gettransactions.map((data){
        return Flexible(
          fit: FlexFit.tight,
            child: Chartbar(data['day'],
                data['amount'],
                maxSpending==0? 0.0:(data['amount']as double)/maxSpending)
        );
      }).toList(),
      ),
    ),);
  }
}
