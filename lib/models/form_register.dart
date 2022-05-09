class FormRegister {
  String? username;
  String? noHandphone;
  String? email;
  String? password;

  FormRegister({this.username, this.noHandphone, this.email, this.password});

  FormRegister.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    noHandphone = json['no_handphone'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['username'] = username.toString();
    data['no_handphone'] = noHandphone.toString();
    data['email'] = email.toString();
    data['password'] = password.toString();
    return data;
  }

  valid() {
    return username != null && noHandphone != null && email != null && password != null;
  }
}
