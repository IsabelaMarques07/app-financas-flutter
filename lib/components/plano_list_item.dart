import 'package:financas_pessoais/models/plano.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlanoListItem extends StatelessWidget {
  final Plano plano;
  final Function remover;
  final Function editar;
  final Function adicionar;

  const PlanoListItem({Key? key, 
                        required this.plano, 
                        required this.remover, 
                        required this.editar, 
                        required this.adicionar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 0),
        padding: const EdgeInsets.only(left: 20, top: 20, right:20, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(plano.nome.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.blue,
              ),),
            Row(
              children: [
                Text(DateFormat('MM/dd/yyyy').format(plano.dataInicial),
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontSize: 16),),
                Text(" até ${DateFormat('MM/dd/yyyy').format(plano.dataFinal)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontSize: 16),),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Text(NumberFormat.simpleCurrency(locale: 'pt_BR').format(plano.valorAtual),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20),),
                 Text(" de ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(plano.valorTotal)}",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16),),
              ],
            ),
            const SizedBox(height: 5,),
            LinearProgressIndicator(
              value:plano.valorAtual/plano.valorTotal,
              minHeight: 10,
              semanticsValue: plano.valorAtual.toString(),
            ),
            Row(children: [
              OutlinedButton(
                onPressed: () {
                  adicionar();
                },
                child: const Text('Adicionar'),
              ),
              const SizedBox(width: 10,),
              OutlinedButton(
                onPressed: () async {
                  remover();
                },
                child: const Text('Remover'),
              ),
              const SizedBox(width: 10,),
              OutlinedButton(
                onPressed: () {
                  editar();
                },
                child: const Text('Editar'),
              )
            ],)
          ],
        ),
        
      ),
      onTap: () {
        Navigator.pushNamed(context, '/plano-detalhes',
            arguments: plano);
      },
    );
  }
}
