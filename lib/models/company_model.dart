class CompanyModel {
  final String name;
  final String email;
  final String cnpj;

  CompanyModel({
    required this.name,
    required this.email,
    required this.cnpj,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'cnpj': cnpj,
    };
  }

  static CompanyModel fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      name: map['name'],
      email: map['email'],
      cnpj: map['cnpj'],
    );
  }
}
