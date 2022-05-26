class DbRegister {
  int? id;
  String? account;
  String? password;
  int? updateTime;
  int? createTime;

  DbRegister({
    this.createTime, this.updateTime, this.password, this.account, this.id,
  });

  DbRegister.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    account = json['account'];
    password = json['password'];
    updateTime = json['updateTime'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['id'] = id;
    map['account'] = account;
    map['password'] = password;
    map['updateTime'] = updateTime;
    map['createTime'] = createTime;
    return map;
  }
}