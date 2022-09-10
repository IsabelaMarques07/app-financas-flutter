import 'package:financas_pessoais/models/plano.dart';
import 'package:flutter/material.dart';

class PlanoListItem extends StatelessWidget {
  final Plano plano;

  const PlanoListItem({Key? key, required this.plano})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(plano.nome),
    );
  }
}
