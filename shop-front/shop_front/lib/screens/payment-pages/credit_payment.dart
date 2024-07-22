import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop_front/components/app_bar_custom.dart';
import 'package:intl/intl.dart';

 
class CreditPayment extends StatefulWidget {
  const CreditPayment({super.key});

  @override
  State<CreditPayment> createState() => _CreditPaymentState();
}

class _CreditPaymentState extends State<CreditPayment> {
  late String valor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    valor = getTotalValue(context);
  }

  String getTotalValue(BuildContext context) {
    final double total =
        double.parse(ModalRoute.of(context)!.settings.arguments.toString());
    return total.toString();
  }

  @override
  Timer? _timer;
  int _start = 59;
  bool _isTimeUp = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isTimeUp = true;
        });
        timer.cancel();
        Future.delayed(Duration(seconds: 4), () {
          Navigator.of(context).pushReplacementNamed('/start');
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double valorDouble = double.parse(valor);
    final format = NumberFormat('##0.00', 'pt_BR');
    final formattedValue = format.format(valorDouble);
    return Scaffold(
      appBar: AppBarCustom(),
      body: Center(
        child: _isTimeUp
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Operação cancelada!',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/start');
                    },
                    child: Text('Voltar para o início'),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 250,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                             Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Icon(Icons.credit_card, size: 100,color:  Colors.blue[600])
                    ,
                      Icon(Icons.lock_clock, color: Colors.amber[800],size: 100,)
                  ],),
                  SizedBox(height: 10),
                  Text(
                    'Valor: R\$$formattedValue',
                    style: TextStyle(fontSize: 15),
                  ),
                      ],
                    )
                  ),
                
                  SizedBox(height: 40),
                  Text(
                    'Tempo restante: ${_start ~/ 60}:${_start % 60}',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 250,
                    child: 
                  Text(
                    "Insira ou passe o cartão de débito na maquininha a sua frente!",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),),
                  SizedBox(height: 20),
                  OutlinedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Operação cancelada!'),
                                content: Text('A transação foi cancelada!'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pushNamed('/start');
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: Text('Cancelar'))
                ],
              ),
      ),
    );
  }
}
