import 'package:controle_vendas_e_estoque/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:controle_vendas_e_estoque/controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final AuthController _authController = AuthController();
  bool _isCnpjRequired = false; // Variável para controlar a caixa de seleção

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryBackground, AppColors.primaryAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.white.withOpacity(0.9),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cadastro",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryAccent,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nameController,
                      style: TextStyle(color: Colors.black), // Define a cor do texto como preto
                      decoration: InputDecoration(
                        labelText: "Nome",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      style: TextStyle(color: Colors.black), // Define a cor do texto como preto
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      style: TextStyle(color: Colors.black), // Define a cor do texto como preto
                      decoration: InputDecoration(
                        labelText: "Senha",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      title: const Text(
                        "Deseja informar o CNPJ?",
                        style: TextStyle(color: AppColors.primaryAccent), // Cor alterada
                      ),
                      value: _isCnpjRequired,
                      onChanged: (bool? value) {
                        setState(() {
                          _isCnpjRequired = value ?? false;
                        });
                      },
                    ),
                    if (_isCnpjRequired) // Só exibe se o checkbox estiver marcado
                      const SizedBox(height: 16),
                    if (_isCnpjRequired)
                      TextField(
                        controller: _cnpjController,
                        style: TextStyle(color: Colors.black), // Define a cor do texto como preto
                        decoration: InputDecoration(
                          labelText: "CNPJ",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        backgroundColor: AppColors.primaryAccent,
                      ),
                      onPressed: () {
                        _authController.registerUser(
                          context,
                          _nameController.text.trim(),
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                          _isCnpjRequired ? _cnpjController.text.trim() : null, // CNPJ será null se não for informado
                        );
                      },
                      child: Center(
                        child: Text(
                          "Cadastrar",
                          style: TextStyle(fontSize: 18, color: AppColors.primaryText),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
