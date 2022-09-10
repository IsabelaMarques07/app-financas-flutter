import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlanoCadastroPage extends StatefulWidget {
  // Plano? transacaoParaEdicao;
  // PlanoCadastroPage({Key? key, this.planoParaEdicao}) : super(key: key);

  @override
  State<PlanoCadastroPage> createState() => _PlanoCadastroPageState();
}


class _PlanoCadastroPageState extends State<PlanoCadastroPage> {

  final _nomeController = TextEditingController();

  @override
    void initState() {
      super.initState();
  }

    final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de plano'),
      ),
            body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildNome(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

    TextFormField _buildNome() {
    return TextFormField(
      controller: _nomeController,
      decoration: const InputDecoration(
        hintText: 'Informe a descrição',
        labelText: 'Nome do plano',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.ac_unit),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um Nome';
        }
        if (value.length < 5 || value.length > 15) {
          return 'O nome deve entre 5 e 15 caracteres';
        }
        return null;
      },
    );
  }

}