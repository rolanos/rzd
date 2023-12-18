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
      map['fam'] != null ? map['fam'] as String : null,
      map['pmg'] != null ? map['pmg'] as int : null,
      map['name'] != null ? map['name'] as String : null,
      map['otch'] != null ? map['otch'] as String : null,
      map['phone'] != null ? map['phone'] as String : null,
      map['snils'] != null ? map['snils'] as String : null,
      map['e-mail'] != null ? map['e-mail'] as String : null,
      map['address'] != null ? map['address'] as String : null,
    );
  }
}
