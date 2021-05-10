import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';
import 'package:personal_expenses/widgets/user_transactions.dart';
import './widgets/new_transactions.dart';
import './models/transaction.dart';
import './widgets/chart.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

      home: MyHomePage(title: 'Weekly Market Costs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  bool  _showchart=false;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  @override
  void  didChangeAppLifecycleState(AppLifecycleState state){
    print(state);
  }
  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  final List<Transaction> _transactions=[];
  List<Transaction> get _recenttransactions{
    return _transactions.where((tx)  {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle,double txAmount,DateTime choosenData){
    final newTx=Transaction(
      title:txTitle,
      amount: txAmount,
      date: choosenData,
      id:DateTime.now().toString(),
    );
    setState(() {
      _transactions.add(newTx);
    });
  }
  void startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return GestureDetector(
        onTap: (){},
          child:NewTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
      );
    },);
  }
  void deleteTransaction(String id){
    setState(() {
      _transactions.removeWhere((tx) => tx.id==id);
    });
  }
  @override
  Widget build(BuildContext context) {
    final isLandescape=MediaQuery.of(context).orientation==Orientation.landscape;
    final appBar= AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: Text(widget.title,
        style: TextStyle(
          fontFamily: 'BLACKAREA',
          fontSize: 32,
          fontWeight: FontWeight.bold,

        ),),

      actions: <Widget>[
        IconButton(
          icon:Icon(Icons.add),
          onPressed: ()=>startAddNewTransaction(context),
        ),
      ],
    );
    final txList = Container(
      height: (MediaQuery.of(context).size.height -
          appBar.preferredSize.height - MediaQuery.of(context).padding.top)*0.65,
      child:TransactionList(_transactions,deleteTransaction),
    );
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: appBar,
      body:SingleChildScrollView(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if(isLandescape)Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
            Text('Show Chart'),
              Switch(value: _showchart,onChanged:(val){
                  setState(() {
                    _showchart=val;
                  });
              }),
          ],),
    if(!isLandescape)Container(
        height: (MediaQuery.of(context).size.height -
        appBar.preferredSize.height - MediaQuery.of(context).padding.top)*0.35,
    child:Chart(_recenttransactions)),
  if(!isLandescape) txList,
if(isLandescape) _showchart ? Container(
      height: (MediaQuery.of(context).size.height -
          appBar.preferredSize.height - MediaQuery.of(context).padding.top)*0.65,
          child:Chart(_recenttransactions),
    ) :txList

    ]
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>startAddNewTransaction(context),
      ),
    );

  }
}
