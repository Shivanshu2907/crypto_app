import 'dart:convert';

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:http/http.dart' as http;

const Key='DD556496-94D9-4103-8A0E-263F7DC598E5';
const url='https://rest.coinapi.io/v1/exchangerate/BTC/INR?apikey=$Key';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String pv = 'USD';
  String bitcoinValue='?';
  String ethereumValue='?';
  String litecoinValue='?';
  
  List<DropdownMenuItem> makeList(List<String> l) {
    List<DropdownMenuItem<String>> s = [];
    for (String item in l) {
      s.add(DropdownMenuItem(child: Text(item), value: item));
    }
    return s;
  }

  void calculate(String cur,String cry)async{
    http.Response response=await http.get('https://rest.coinapi.io/v1/exchangerate/$cry/$cur?apikey=$Key');
    String data=response.body;
    double value=jsonDecode(data)['rate'];
      if(cry=='BTC'){
        setState(() {
          bitcoinValue=value.toStringAsFixed(0);
        });
      }
      else if(cry=='ETH'){
        setState(() {
          ethereumValue=value.toStringAsFixed(0);
        });
      }
      else if(cry=='LTC'){
        setState(() {
          litecoinValue=value.toStringAsFixed(0);
        });
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculate(pv, 'BTC'); 
    calculate(pv, 'ETH'); 
    calculate(pv, 'LTC'); 
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $bitcoinValue $pv',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $ethereumValue $pv',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 0, 18.0, 140),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $litecoinValue $pv',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 110.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: DropdownButton<String>(
                value: pv,
                items: makeList(currenciesList),
                onChanged: (val) {
                  setState(() {
                    pv = val;
                    calculate(pv, 'BTC');
                    calculate(pv, 'ETH');
                    calculate(pv, 'LTC');
                  });
                },
              )),
        ],
      ),
    );
  }
}
