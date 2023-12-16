import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserHistory {
  final int id;
  final String type;
  final String state;
  final DateTime moment;
  final String comment;
  final String subject;
  final String application;
  UserHistory({
    required this.id,
    required this.type,
    required this.state,
    required this.moment,
    required this.comment,
    required this.subject,
    required this.application,
  });
}
