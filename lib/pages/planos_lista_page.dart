import 'package:financas_pessoais/components/plano_list_item.dart';
import 'package:financas_pessoais/models/plano.dart';
import 'package:financas_pessoais/pages/plano_cadastro_page.dart';
import 'package:financas_pessoais/repository/plano_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PlanosListaPage extends StatefulWidget {
  const PlanosListaPage({Key? key}) : super(key: key);

  @override
  State<PlanosListaPage> createState() => _PlanosListaPageState();
}


class _PlanosListaPageState extends State<PlanosListaPage> {
  final _planoRepository = PlanoRepository();
  late Future<List<Plano>> _futurePlanos;

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
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) async {
                          // await _planoRepository
                          //     .removerLancamento(plano.id!);

                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //         content:
                          //             Text('Lançamento removido com sucesso')));

                          // setState(() {
                          //   planos.removeAt(index);
                          // });
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Remover',
                      ),
                      SlidableAction(
                        onPressed: (context) async {
                          // var success = await Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (BuildContext context) =>
                          //         PlanoCadastroPage(
                          //       transacaoParaEdicao: plano,
                          //     ),
                          //   ),
                          // ) as bool?;

                          // if (success != null && success) {
                          //   setState(() {
                          //     carregarTransacoes();
                          //   });
                          // }
                        },
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Editar',
                      ),
                    ],
                  ),
                  child: PlanoListItem(plano: plano),
                );
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
                // carregarPlanos();
              });
            }
          },
          child: const Icon(Icons.add)),
    );
  }
}
