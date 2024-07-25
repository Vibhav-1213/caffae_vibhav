import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String user_first_name;
  final String user_last_name;
  final String user_email;
  final String? user_uid;

  const UserModel({
    this.user_uid,
    required this.user_email,
    required this.user_first_name,
    required this.user_last_name
  });

  toJson() {
    return {"FirstName" : user_first_name, "LastName" : user_last_name, "Email" : user_email, "userid" : user_uid};
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return UserModel(
      user_uid: document.id,
      user_email: data["email"], 
      user_first_name: data["firstname"], 
      user_last_name: data["lastname"]
    );
  }

}