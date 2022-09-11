import 'package:financas_pessoais/database/database_manager.dart';
import 'package:financas_pessoais/models/plano.dart';

class PlanoRepository {
  Future<List<Plano>> listarPlanos() async {
    final db = await DatabaseManager().getDatabase();

    // Listar Planos do Banco de dados
    // Retorna uma Lista de Map (chave/valor)
    // onde a chave é o nome da coluna no banco de dados
    final List<Map<String, dynamic>> rows = await db.query('planos');

    // Mapear a lista de <Map> para uma lista de <Categoria>
    return rows
        .map(
          (row) => Plano(
              id: row['id'],
              nome: row['nome'],
              valorTotal: row['valorTotal'],
              valorAtual: row['valorAtual'],
              dataInicial: DateTime.fromMillisecondsSinceEpoch(row['dataInicial']),
              dataFinal: DateTime.fromMillisecondsSinceEpoch(row['dataFinal']),
        )
        )
        .toList();
  }

    Future<void> cadastrarPlano(Plano plano) async {
    final db = await DatabaseManager().getDatabase();

    db.insert("planos", {
      "id": plano.id,
      "nome": plano.nome,
      "valorTotal": plano.valorTotal,
      "valorAtual": plano.valorAtual,
      "dataInicial": plano.dataInicial.millisecondsSinceEpoch,
      "dataFinal": plano.dataFinal.millisecondsSinceEpoch,
    });
  }
}
