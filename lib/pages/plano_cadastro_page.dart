import 'package:financas_pessoais/models/plano.dart';
import 'package:financas_pessoais/repository/plano_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';

class PlanoCadastroPage extends StatefulWidget {
  Plano? planoParaEdicao;
  PlanoCadastroPage({Key? key, this.planoParaEdicao}) : super(key: key);

  @override
  State<PlanoCadastroPage> createState() => _PlanoCadastroPageState();
}


class _PlanoCadastroPageState extends State<PlanoCadastroPage> {

  PlanoRepository _planoRepository = PlanoRepository();
  final _nomeController = TextEditingController();
  final _valorAtualController = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$');
  final _valorTotalController = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$'); 
  final _dataInicialController = TextEditingController();     
  final _dataFinalController = TextEditingController();     


  @override
    void initState() {
      super.initState();

      
    final plano = widget.planoParaEdicao;
      if(plano != null) {
      _nomeController.text = plano.nome;
      _valorAtualController.text =
          NumberFormat.simpleCurrency(locale: 'pt_BR').format(plano.valorAtual);
      _valorTotalController.text =
          NumberFormat.simpleCurrency(locale: 'pt_BR').format(plano.valorTotal);
      _dataInicialController.text = DateFormat('MM/dd/yyyy').format(plano.dataInicial);
      _dataFinalController.text = DateFormat('MM/dd/yyyy').format(plano.dataFinal);
  }
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
                _buildDataInicial(),
                const SizedBox(height: 20),
                _buildDataFinal(),
                const SizedBox(height: 20),
                _buildValorAtual(),
                const SizedBox(height: 20),
                _buildValorTotal(),
                const SizedBox(height: 20),
                _buildButton(),
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
        if (value.length < 5 || value.length > 30) {
          return 'O nome deve entre 4 e 30 caracteres';
        }
        return null;
      },
    );
  }

      TextFormField _buildValorTotal() {
    return TextFormField(
      controller: _valorTotalController,
      decoration: const InputDecoration(
        hintText: 'Informe o valor total',
        labelText: 'Valor total',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.money),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um Valor total';
        }
        final valor = NumberFormat.currency(locale: 'pt_BR')
            .parse(_valorTotalController.text.replaceAll('R\$', ''));
        if (valor <= 0) {
          return 'Informe um valor maior que zero';
        }

        return null;
      },
    );
  }

    TextFormField _buildValorAtual() {
    return TextFormField(
      controller: _valorAtualController,
      decoration: const InputDecoration(
        hintText: 'Informe o valor acumulado até o momento',
        labelText: 'Valor atual',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.money),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um Valor';
        }
        final valor = NumberFormat.currency(locale: 'pt_BR')
            .parse(_valorAtualController.text.replaceAll('R\$', ''));
        if (valor <= 0) {
          return 'Informe um valor maior que zero';
        }

        return null;
      },
    );
  }

    TextFormField _buildDataInicial() {
    return TextFormField(
      controller: _dataInicialController,
      decoration: const InputDecoration(
        hintText: 'Informe uma Data Inicial',
        labelText: 'Data Inicial',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.calendar_month),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());

        DateTime? dataSelecionada = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (dataSelecionada != null) {
          _dataInicialController.text =
              DateFormat('dd/MM/yyyy').format(dataSelecionada);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe uma Data de Início';
        }

        try {
          DateFormat('dd/MM/yyyy').parse(value);
        } on FormatException {
          return 'Formato de data inválida';
        }

        return null;
      },
    );
  }

    TextFormField _buildDataFinal() {
    return TextFormField(
      controller: _dataFinalController,
      decoration: const InputDecoration(
        hintText: 'Informe uma Data de fim',
        labelText: 'Data Final',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.calendar_month),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());

        DateTime? dataSelecionada = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (dataSelecionada != null) {
          _dataFinalController.text =
              DateFormat('dd/MM/yyyy').format(dataSelecionada);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe uma Data de fim';
        }

        try {
          DateFormat('dd/MM/yyyy').parse(value);
        } on FormatException {
          return 'Formato de data inválida';
        }

        return null;
      },
    );
  }

  SizedBox _buildButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Cadastrar'),
        ),
        onPressed: () async {
          final isValid = _formKey.currentState!.validate();
          if (isValid) {

             final nome = _nomeController.text;
             final dataInicial =DateFormat('dd/MM/yyyy').parse(_dataInicialController.text);
             final dataFinal = DateFormat('dd/MM/yyyy').parse(_dataFinalController.text);
            final valorAtual = NumberFormat.currency(locale: 'pt_BR')
                .parse(_valorAtualController.text.replaceAll('R\$', ''))
                .toDouble();
            final valorTotal = NumberFormat.currency(locale: 'pt_BR')
                .parse(_valorTotalController.text.replaceAll('R\$', ''))
                .toDouble();

            final plano = Plano(
              nome: nome,
              valorAtual: valorAtual,
              valorTotal: valorTotal,
              dataFinal: dataFinal,
              dataInicial: dataInicial,
            );

            try {
              if (widget.planoParaEdicao != null) {
                plano.id = widget.planoParaEdicao!.id;
                await _planoRepository.editarPlano(plano);
              } else {
                await _planoRepository.cadastrarPlano(plano);
              }

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Plano cadastrado com sucesso'),
              ));

              Navigator.of(context).pop(true);
            } catch (e) {
              Navigator.of(context).pop(false);
            }
          }
        },
      ),
    );
  }

}