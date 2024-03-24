// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:rzd/features/auth/domain/entity/bank_account.dart';

class UserProfile {
  final String? fam;
  final int? pmg;
  final String? name;
  final String? otch;
  final String? phone;
  final String? snils;
  final String? email;
  final int? status;
  final String? address;
  final String? assignes;
  final String? passport;
  final String? birthDate;
  final String? department;
  final String? experience;
  final int? idPolygon;
  final String? statusName;

  final BankAccount? bankAccount;
  final DateTime? retirementDate;

  UserProfile({
    this.fam,
    this.pmg,
    this.name,
    this.otch,
    this.phone,
    this.snils,
    this.email,
    this.status,
    this.address,
    this.assignes,
    this.passport,
    this.birthDate,
    this.department,
    this.experience,
    this.idPolygon,
    this.statusName,
    this.bankAccount,
    this.retirementDate,
  });

  ///...
}
