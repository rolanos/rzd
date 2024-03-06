class BankAccount {
  final String? bic;
  final String? account;
  final String? bankName;

  BankAccount(
      {required this.bic, required this.account, required this.bankName});

  static BankAccount fromMap(Map<String, dynamic> map) {
    return BankAccount(
      bic: map['bic'],
      account: map['account'],
      bankName: map['bank_name'],
    );
  }
}
