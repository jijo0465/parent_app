class Parent {
  int _id;
  String _name;
  String _password;
  int _personId;
  String _phoneNumber;
  String _photoUrl;

  get id => _id;
  get name => _name;
  get password => _password;
  get personId => _personId;
  get phoneNumber => _phoneNumber;
  get photoUrl => _photoUrl;

  Parent(int id, String name, String password, int personId, String phoneNumber,
      String photoUrl) {
    this._id = id;
    this._name = name;
    this._password = password;
    this._personId = personId;
    this._phoneNumber = phoneNumber;
    this._photoUrl = photoUrl;
  }

  setId(int id) {
    this._id = id;
  }

  setName(String name) {
    this._name = name;
  }

  factory Parent.fromMap(Map<String, dynamic> value) {
    Parent parent = Parent(
      value['id'], 
      value['name'], 
      value['password'],
      value['personId'], 
      value['phoneNumber'], 
      value['photoUrl']);
    return parent;
  }
}
