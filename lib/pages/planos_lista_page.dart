import 'package:financas_pessoais/components/plano_list_item.dart';
import 'package:financas_pessoais/models/plano.dart';
import 'package:financas_pessoais/pages/plano_cadastro_page.dart';
import 'package:financas_pessoais/repository/plano_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class PlanosListaPage extends StatefulWidget {
  const PlanosListaPage({Key? key}) : super(key: key);

  @override
  State<PlanosListaPage> createState() => _PlanosListaPageState();
}


class _PlanosListaPageState extends State<PlanosListaPage> {
  final _planoRepository = PlanoRepository();
  late Future<List<Plano>> _futurePlanos;

  final _valorAdicionalController = MoneyMaskedTextController(
    decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$');

  @override
  void initState() {
    carregarPlanos();
    super.initState();
  }

    void carregarPlanos() {
    _futurePlanos = _planoRepository.listarPlanos();
  }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planos'),
      ),
      body: FutureBuilder<List<Plano>>(
        future: _futurePlanos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final planos = snapshot.data ?? [];
            return ListView.separated(
              itemCount: planos.length,
              itemBuilder: (context, index) {
                final plano = planos[index];
                void remover() async {
                    await _planoRepository
                      .removerLancamento(plano.id!);

                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Lançamento removido com sucesso')));

                    setState(() {
                      planos.removeAt(index);
                    });
                } 
              void editar() async{
                var success = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        PlanoCadastroPage(
                      planoParaEdicao: plano,
                    ),
                  ),
                ) as bool?;

                if (success != null && success) {
                  setState(() {
                    carregarPlanos();
                  });
                }
              }
              void adicionar() async{
                return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Stack(
                        // overflow: Overflow.visible,
                        children: <Widget>[
                          Positioned(
                            right: -40.0,
                            top: -40.0,
                            child: InkResponse(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.red,
                                child: Icon(Icons.close),
                              ),
                            ),
                          ),
                          Form(
                            // key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text("Adicionar valor"),
                                const SizedBox(height: 20,),
                                _buildValorAdicional(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    child: Text("Adicionar"),
                                    onPressed: () async {
                                      final valorAdicional = NumberFormat.currency(locale: 'pt_BR')
                                        .parse(_valorAdicionalController.text.replaceAll('R\$', ''))
                                        .toDouble();
                                      await _planoRepository
                                        .adicionarValor(plano, valorAdicional);

                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text('Valor atual do plano atualizado com sucesso')));

                                      setState(() {
                                        carregarPlanos();
                                        Navigator.of(context).pop();
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                });
              }
                return PlanoListItem(plano: plano, remover: remover, editar: editar, adicionar:adicionar);
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool? planoCadastrado = await Navigator.of(context)
                .pushNamed('/plano-cadastro') as bool?;

            if (planoCadastrado != null && planoCadastrado) {
              setState(() {
                carregarPlanos();
              });
            }
          },
          child: const Icon(Icons.add)),
    );
  }

    TextFormField _buildValorAdicional() {
    return TextFormField(
      controller: _valorAdicionalController,
      decoration: const InputDecoration(
        hintText: 'Informe o valor que deseja adicionar',
        labelText: 'Valor atual',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.money),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um Valor';
        }
        final valor = NumberFormat.currency(locale: 'pt_BR')
            .parse(_valorAdicionalController.text.replaceAll('R\$', ''));
        if (valor <= 0) {
          return 'Informe um valor maior que zero';
        }

        return null;
      },
    );
  }
}



 