import 'package:intl/intl.dart';
import 'package:rzd/features/auth/domain/entity/bank_account.dart';
import 'package:rzd/features/auth/domain/entity/user_model.dart';

class UserProfileApi {
  Map<String, dynamic> toMap(UserProfile userProfile) {
    return <String, dynamic>{
      'fam': userProfile.fam,
      'pmg': userProfile.pmg,
      'name': userProfile.name,
      'otch': userProfile.otch,
      'phone': userProfile.phone,
      'snils': userProfile.snils,
      'email': userProfile.email,
      'address': userProfile.address,
    };
  }

  static UserProfile fromMap(Map<String, dynamic> map) {
    return UserProfile(
      fam: map['fam'] != null ? map['fam'] as String : null,
      pmg: map['pmg'] != null ? map['pmg'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      otch: map['otch'] != null ? map['otch'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      snils: map['snils'] != null ? map['snils'] as String : null,
      email: map['e-mail'] != null ? map['e-mail'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      assignes: map['assignes'] != null ? map['assignes'] as String : null,
      passport: map['passport'] != null ? map['passport'] as String : null,
      birthDate: map['birthdate'] != null ? map['birthdate'] as String : null,
      department:
          map['department'] != null ? map['department'] as String : null,
      experience:
          map['experience'] != null ? map['experience'] as String : null,
      idPolygon: map['id_polygon'] != null ? map['id_polygon'] as int : null,
      statusName:
          map['statusName'] != null ? map['statusName'] as String : null,
      bankAccount: map['bankaccount'] != null
          ? BankAccount.fromMap(map['bankaccount'] as Map<String, dynamic>)
          : null,
      retirementDate: map['retirement_date'] != null
          ? DateFormat('dd.MM.yyyy').parse(map['retirement_date'] as String)
          : null,
    );
  }
}
