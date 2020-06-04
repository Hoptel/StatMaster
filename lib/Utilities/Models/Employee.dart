class Employee {
  int id;
  String code;
  String guid;
  String address;
  int authlevel;
  String bankname;
  String birthdate;
  String birthplace;
  String bloodgrp;
  String city;
  int companyid;
  String country;
  String department;
  String email;
  String fullname;
  String gender;
  bool haslogin;
  String iban;
  String idno;
  int langid;
  String maritalstatus;
  String nation;
  int paycurrid;
  double salaryamount;
  int salaryday;
  String startdate;
  String enddate;
  String taxnumber;
  String tel;
  String tel2;
  int userid;
  
  Map<String, dynamic> jsonMap;

  
  Employee({

    this.id,
    this.code,
    this.guid,
    this.address,
    this.authlevel,
    this.bankname,
    this.birthdate,
    this.birthplace,
    this.bloodgrp,
    this.city,
    this.companyid,
    this.country,
    this.department,
    this.email,
    this.fullname,
    this.gender,
    this.haslogin,
    this.iban,
    this.idno,
    this.langid,
    this.maritalstatus,
    this.nation,
    this.paycurrid,
    this.salaryamount,
    this.salaryday,
    this.startdate,
    this.enddate,
    this.taxnumber,
    this.tel,
    this.tel2,
    this.userid,
    this.jsonMap,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
id: json['id'],
code: json['code'],
guid: json['guid'],
address: json['address'],
authlevel: json['authlevel'],
bankname: json['bankname'],
birthdate: json['birthdate'],
birthplace: json['birthplace'],
bloodgrp: json['bloodgrp'],
city: json['city'],
companyid: json['companyid'],
country: json['country'],
department: json['department'],
email: json['email'],
fullname: json['fullname'],
gender: json['gender'],
haslogin: json['haslogin'],
iban: json['iban'],
idno: json['idno'],
langid: json['langid'],
maritalstatus: json['maritalstatus'],
nation: json['nation'],
paycurrid: json['paycurrid'],
salaryamount: json['salaryamount'],
salaryday: json['salaryday'],
startdate: json['startdate'],
enddate: json['enddate'],
taxnumber: json['taxnumber'],
tel: json['tel'],
tel2: json['tel2'],
userid: json['userid']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{
    'id': id,
    'code': code,
    'guid': guid,
    'address': address,
    'authlevel': authlevel,
    'bankname': bankname,
    'birthdate': birthdate,
    'birthplace': birthplace,
    'bloodgrp': bloodgrp,
    'city': city,
    'companyid': companyid,
    'country': country,
    'department': department,
    'email': email,
    'fullname': fullname,
    'gender': gender,
    'haslogin': haslogin,
    'iban': iban,
    'idno': idno,
    'langid': langid,
    'maritalstatus': maritalstatus,
    'nation': nation,
    'paycurrid': paycurrid,
    'salaryamount': salaryamount,
    'salaryday': salaryday,
    'startdate': startdate,
    'enddate': enddate,
    'taxnumber': taxnumber,
    'tel': tel,
    'tel2': tel2,
    'userid': userid,
    };
    return map;
  }
  
}
