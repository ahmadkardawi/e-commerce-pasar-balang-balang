class UserModel {
  String? name;
  String? email;
  String? password;
  String? noHp;
  String? uid;
  String? role;
  String? image;
  String? alamat;
  String? token;

  UserModel(
      {this.name,
      this.email,
      this.password,
      this.noHp,
      this.alamat,
      this.uid,
      this.role = " ",
      this.image,
      this.token});

  factory UserModel.fromJson(json) {
    return UserModel(
      name: json['name'],
      alamat: json['alamat'],
      email: json['email'],
      password: json['password'],
      noHp: json['noHp'],
      image: json['image'],
      uid: json['uid'],
      role: json['role'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'alamat': alamat,
      'image': image,
      'name': name,
      'noHp': noHp,
      'role': role,
      'token': token,
    };
  }
}
