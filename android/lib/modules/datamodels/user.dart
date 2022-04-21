import 'package:firebase_database/firebase_database.dart';

class UserP {
  String fullName;
  String email;
  String phone;
  String id;

  UserP({
    this.email,
    this.fullName,
    this.phone,
    this.id,
  });
  UserP.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.key;
    Map val = snapshot.value;
    phone = val['phone'];
    email = val['email'];
    fullName = val['fullname'];
  }
}
