class UserModel {
  String id;
  String email;
  String password;
  String cpassword;
  String firstname;
  String lastname;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.cpassword,
    required this.firstname,
    required this.lastname,
  });

  // تحويل الكائن إلى خريطة (Map) لكي يتم تخزينه في Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'cpassword': cpassword,
      'firstname': firstname,
      'lastname': lastname,
    };
  }

  // تحويل البيانات من خريطة إلى كائن UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      cpassword: map['cpassword'],
      firstname: map['firstname'],
      lastname: map['lastname'],
    );
  }
}
