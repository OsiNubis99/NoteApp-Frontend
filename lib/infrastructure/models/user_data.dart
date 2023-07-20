class UserData {
  static final UserData _instance = UserData._internal();

  factory UserData() => _instance;

  UserData._internal() {
    _id = 1;
  }

  late int _id;

  //short getter for my variable
  int get id => _id;

  //short setter for my variable
  set id(int value) => _id = value;
}
