class UserInfo {
  int authlevel; //it's the same as scope from the other thing
  String code; //username
  String email;
  String gid;
  int hotelrefno;
  int id;
  String shortcode;
  int userid;

  //Do not use this [constructor] to create the models; Use fromJson instead.
  UserInfo({
    this.authlevel,
    this.code,
    this.email,
    this.gid,
    this.hotelrefno,
    this.id,
    this.shortcode,
    this.userid,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      authlevel: json['authlevel'],
      code: json['code'],
      email: json['email'],
      gid: json['gid'],
      hotelrefno: json['hotelrefno'],
      id: json['id'],
      shortcode: json['shortcode'],
      userid: json['userid'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfo &&
          runtimeType == other.runtimeType &&
          authlevel == other.authlevel &&
          code == other.code &&
          email == other.email &&
          gid == other.gid &&
          hotelrefno == other.hotelrefno &&
          id == other.id &&
          shortcode == other.shortcode &&
          userid == other.userid;

  @override
  int get hashCode =>
      authlevel.hashCode ^
      code.hashCode ^
      email.hashCode ^
      gid.hashCode ^
      hotelrefno.hashCode ^
      id.hashCode ^
      shortcode.hashCode ^
      userid.hashCode;

  @override
  String toString() => "UserInfo{authlevel : $authlevel, code : $code, email : $email, gid : $gid, hotelrefno : $hotelrefno, id : $id, shortcode : $shortcode, userid : $userid}";
}
