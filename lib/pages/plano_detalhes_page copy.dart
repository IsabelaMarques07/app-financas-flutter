import 'package:financas_pessoais/models/plano.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlanoDetalhesPage extends StatelessWidget {
  const PlanoDetalhesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final plano = ModalRoute.of(context)!.settings.arguments as Plano;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(plano.nome),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('Valor total'),
              subtitle: Text(NumberFormat.simpleCurrency(locale: 'pt_BR')
                  .format(plano.valorTotal)),
            ),
            ListTile(
              title: const Text('Valor Atual'),
              subtitle: Text(NumberFormat.simpleCurrency(locale: 'pt_BR')
                  .format(plano.valorAtual)),
            ),
            ListTile(
              title: const Text('Data Inicial'),
              subtitle: Text(DateFormat('MM/dd/yyyy').format(plano.dataInicial)),
            ),
            ListTile(
              title: const Text('Data Final'),
              subtitle: Text(DateFormat('MM/dd/yyyy').format(plano.dataFinal)),
            ),
          ],
        ),
      ),
    );
  }
}
