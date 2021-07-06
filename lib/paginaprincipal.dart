import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_trabalhofinaleletiva/drop_down.dart';
import 'package:flutter_app_trabalhofinaleletiva/api_client.dart';

class PaginaPrincipal extends StatefulWidget {
  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  ApiClient client = ApiClient();
  
  Color corPrincipal = Color(0xFF212936); 
  Color corSegundaria = Color(0xFF00C853);
  List<String> currencies;
  String from;
  String to;

  double rate;
  String result = "";


  Future<List<String>> getCurrencyList() async{
    return await client.getCurrencies();
  }
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    // ignore: unnecessary_statements
    (() async {
      List<String> list = await client.getCurrencies();
      setState(() {
        currencies = list;
      });
    })();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corPrincipal,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300,
                child: Text('Conversor de Moedas', style: TextStyle(
                  color: Colors.greenAccent[700],
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
               ),
              ),
              Expanded(
                child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      onSubmitted: (value) async {
                        rate = await client.getRate(from, to);
                        setState(() {
                          result = (rate * double.parse(value)).toStringAsFixed(2);
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Coloque o valor para converter',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18.0,
                          color: corSegundaria,
                        )),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       customDropDown(currencies, from, (val){setState(() {
                         from = val;
                       });}),
                       FloatingActionButton(
                          onPressed: () {
                           String temp = from;
                           setState(() {
                             from = to;
                             to = temp;
                           });
                         }, 
                          child: Icon(Icons.swap_horiz), 
                          elevation: 0.0, 
                          backgroundColor: corSegundaria,
                       ),
                       customDropDown(currencies, to, (val){setState(() {
                         to = val;
                       });})
                      ],
                    ),
                    SizedBox(height: 50.0),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: Column(
                        children: [
                          Text("Result", style: TextStyle(
                            color: Colors.black, 
                            fontSize: 24.0, 
                            fontWeight: FontWeight.bold,
                            )),
                          Text(result, style: TextStyle(
                            color: corSegundaria,
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold,
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}