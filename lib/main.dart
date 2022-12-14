import 'package:financas_pessoais/pages/home_page.dart';
import 'package:financas_pessoais/pages/plano_cadastro_page.dart';
import 'package:financas_pessoais/pages/plano_detalhes_page%20copy.dart';
import 'package:financas_pessoais/pages/transacao_cadastro_page.dart';
import 'package:financas_pessoais/pages/transacao_detalhes_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/transacao-detalhes': (context) => const TransacaoDetalhesPage(),
        '/transacao-cadastro': (context) => TransacaoCadastroPage(),
        '/plano-cadastro': (context) => PlanoCadastroPage(),
        '/plano-detalhes': (context) => const PlanoDetalhesPage(),
      },
      initialRoute: '/',
    );
  }
}
