import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../controllers/company_controller.dart';  // Importando o controlador para buscar dados

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    if (userProvider.userId == null) {
      return const CircularProgressIndicator();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão de Estoque'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              userProvider.clearUser(); // Deslogar o usuário
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<String>(
          future: CompanyController().fetchCompanyName(userProvider.userId!),  // Chama o controlador
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar nome da empresa: ${snapshot.error}'));
            }

            return ListView(
              children: [
                Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bem-vindo, ${snapshot.data}',  // Exibe o nome da empresa
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Aqui você pode gerenciar seu estoque de produtos.',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Implementar navegação para a tela de estoque
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50), backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Ir para Estoque',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FloatingActionButton(
                  onPressed: () {
                    // Implementar ação para adicionar novo produto ou recurso
                  },
                  tooltip: 'Adicionar Produto',
                  child: const Icon(Icons.add),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
