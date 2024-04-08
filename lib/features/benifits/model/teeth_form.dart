// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

class TeethForm {
  final String type_service;
  final int? chuz;
  final String? mobile_phone;
  final String? home_phone;
  final String? email;
  final String? comment;
  final File? medicalSertificate;
  final File? documentContract;
  final File? documentAct;
  final File? documentTickets;
  final File? documentOther;

  TeethForm({
    required this.type_service,
    this.chuz,
    this.mobile_phone,
    this.home_phone,
    this.email,
    this.comment,
    this.medicalSertificate,
    this.documentContract,
    this.documentAct,
    this.documentTickets,
    this.documentOther,
  });

  Map<String, dynamic> toMap() {
    String? medicalCertifiacteStr;
    if (medicalSertificate != null) {
      medicalCertifiacteStr =
          base64Encode(medicalSertificate!.readAsBytesSync().toList());
    }
    String? documentContractStr;
    if (documentContract != null) {
      documentContractStr =
          base64Encode(documentContract!.readAsBytesSync().toList());
    }
    String? documentActsStr;
    if (documentAct != null) {
      documentActsStr = base64Encode(documentAct!.readAsBytesSync().toList());
    }
    String? documentTicketsStr;
    if (documentTickets != null) {
      documentTicketsStr =
          base64Encode(documentTickets!.readAsBytesSync().toList());
    }
    String? documentOtherStr;
    if (documentOther != null) {
      documentOtherStr =
          base64Encode(documentOther!.readAsBytesSync().toList());
    }

    return <String, dynamic>{
      'type_service': type_service,
      'chuz': chuz,
      'mobile_phone': mobile_phone,
      'home_phone': home_phone,
      'email': email,
      'comment': comment,
      'medical_certificate': medicalCertifiacteStr,
      'document_contract': documentContractStr,
      'document_act': documentActsStr,
      'document_tickets': documentTicketsStr,
      'document_other': documentOtherStr,
    };
  }
}
