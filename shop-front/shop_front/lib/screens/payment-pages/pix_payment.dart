import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_front/components/app_bar_custom.dart';
import 'package:intl/intl.dart';

class PixPayment extends StatefulWidget {
  @override
  _PixPaymentState createState() => _PixPaymentState();
}

class _PixPaymentState extends State<PixPayment> {
  Uint8List? qrCodeImage;
  String? errorMessage;
  Timer? _timer;
  int _start = 59;
  bool _isTimeUp = false;

  final String chave = '83bed623-f699-4ba0-a9bc-9a50fa93168e';
  final String nome = 'Diogo Carpinelli';
  final String cidade = 'São Paulo';
  final String saida = 'qr';
  late String valor;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    valor = getTotalValue(context);
    getQrCode();
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

  String getTotalValue(BuildContext context) {
    final double total = double.parse(ModalRoute.of(context)!.settings.arguments.toString());
    return total.toString();
  }

  Future<void> getQrCode() async {
    setState(() {
      qrCodeImage = null;
      errorMessage = null;
    });

    final url = Uri.parse(
      'http://localhost:8081/qrcode/getQrCode?nome=$nome&cidade=$cidade&valor=$valor&saida=$saida&chave=$chave',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          qrCodeImage = response.bodyBytes;
        });
      } else {
        setState(() {
          errorMessage = 'Falha ao carregar o QR Code!';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Erro ao fazer a requisição: $e';
      });
    }
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
                    style: TextStyle(fontSize: 15, color: Colors.red),
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
                  Text(
                    'Escaneie o QRCode para efetuar o pagamento',
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  qrCodeImage != null
                      ? Image.memory(qrCodeImage!, width: 140, height: 140,)
                      : errorMessage != null
                          ? Text(errorMessage!)
                          : CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(
                    'Valor: R\$$formattedValue',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Tempo restante: ${_start ~/ 60}:${_start % 60}',
                    style: TextStyle(fontSize: 15),
                  ),
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
