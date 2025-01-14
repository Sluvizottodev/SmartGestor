import 'package:controle_vendas_e_estoque/models/model_product.dart';
import 'package:controle_vendas_e_estoque/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../controllers/product_controller.dart';

class ProductCreationScreen extends StatefulWidget {
  const ProductCreationScreen({super.key});

  @override
  _ProductCreationScreenState createState() => _ProductCreationScreenState();
}

class _ProductCreationScreenState extends State<ProductCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _productName = '';
  String _selectedModel = '';
  String _color = '';
  String _observations = '';
  List<ModelProduct> _models = [];
  bool _isLoading = false;
  bool _isCreatingModel = false; // Flag to toggle model creation view

  @override
  void initState() {
    super.initState();
    _loadModels();
  }

  Future<void> _loadModels() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _models = await ProductController().fetchModels();
      if (_models.isEmpty) {
        // Adiciona um modelo "único" caso não haja modelos disponíveis
        setState(() {
          _models.add(ModelProduct(id: 'unique_model', name: 'Modelo Único', color: '', observations: '', stock: 0));
        });
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _saveProduct() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final companyId = userProvider.userId;

    if (companyId == null || !_formKey.currentState!.validate()) return;

    final product = ProductModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _productName,
      observations: _observations,
      models: _models,
    );

    try {
      await ProductController().saveProduct(companyId, product);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produto salvo com sucesso!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar produto: $e')),
      );
    }
  }

  void _saveModel() async {
    if (_color.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cor do modelo é obrigatória')),
      );
      return;
    }

    final model = ModelProduct(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'Novo Modelo',
      color: _color,
      observations: _observations,
      stock: 0, // Inicializando o estoque como 0
    );

    try {
      await ProductController().saveModelProduct(model);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Modelo salvo com sucesso!')),
      );
      setState(() {
        _models.add(model); // Atualiza a lista de modelos após salvar
        _isCreatingModel = false; // Fecha a criação de modelo após salvar
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar modelo: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome do Produto'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                onChanged: (value) => setState(() => _productName = value),
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Modelo de Produto'),
                items: _models
                    .map((model) => DropdownMenuItem<String>(
                  value: model.id,
                  child: Text(model.name),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedModel = value!),
                hint: _models.isEmpty
                    ? const Text("Selecione um modelo")
                    : const Text("Escolha ou crie um novo modelo"),
              ),
              _isCreatingModel
                  ? Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Cor do Modelo'),
                    onChanged: (value) => setState(() => _color = value),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Observações do Modelo'),
                    onChanged: (value) => setState(() => _observations = value),
                  ),
                  ElevatedButton(
                    onPressed: _saveModel, // Para salvar o modelo
                    child: const Text('Salvar Modelo'),
                  ),
                ],
              )
                  : const SizedBox.shrink(),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isCreatingModel = !_isCreatingModel; // Alterna a visibilidade
                  });
                },
                child: Text(_isCreatingModel ? 'Cancelar Criação de Modelo' : 'Criar Novo Modelo'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduct, // Para salvar o produto
                child: const Text('Salvar Produto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
